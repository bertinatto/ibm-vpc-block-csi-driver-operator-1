FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.19-openshift-4.12 AS builder
WORKDIR /go/src/github.com/openshift/ibm-vpc-block-csi-driver-operator
COPY . .
RUN make

FROM registry.ci.openshift.org/ocp/4.12:base
COPY --from=builder /go/src/github.com/openshift/ibm-vpc-block-csi-driver-operator/ibm-vpc-block-csi-driver-operator /usr/bin
COPY manifests /manifests
ENTRYPOINT ["/usr/bin/ibm-vpc-block-csi-driver-operator"]
LABEL io.k8s.display-name="OpenShift IBM VPC Block CSI Driver Operator" \
	io.k8s.description="The IBM VPC Block CSI Driver Operator installs and maintains the IBM VPC Block CSI Driver on a cluster."
