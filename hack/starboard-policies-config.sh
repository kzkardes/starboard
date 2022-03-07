#!/usr/bin/env bash

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
DEFSEC_DIR=$TMPDIR/defsec

git clone git@github.com:aquasecurity/defsec.git $DEFSEC_DIR

kubectl create configmap starboard-policies-config --namespace starboard-system \
  --from-file=library.kubernetes.rego=$DEFSEC_DIR/rules/kubernetes/lib/kubernetes.rego \
  --from-file=library.utils.rego=$DEFSEC_DIR/rules/kubernetes/lib/utils.rego \
  --from-file=policy.CPU_not_limited.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/CPU_not_limited.rego \
  --from-file=policy.CPU_requests_not_specified.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/CPU_requests_not_specified.rego \
  --from-file=policy.SYS_ADMIN_capability.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/SYS_ADMIN_capability.rego \
  --from-file=policy.capabilities_no_drop_all.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/capabilities_no_drop_all.rego \
  --from-file=policy.file_system_not_read_only.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/file_system_not_read_only.rego \
  --from-file=policy.memory_not_limited.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/memory_not_limited.rego \
  --from-file=policy.memory_requests_not_specified.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/memory_requests_not_specified.rego \
  --from-file=policy.mounts_docker_socket.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/mounts_docker_socket.rego \
  --from-file=policy.runs_with_GID_le_10000.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/runs_with_GID_le_10000.rego \
  --from-file=policy.runs_with_UID_le_10000.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/runs_with_UID_le_10000.rego \
  --from-file=policy.tiller_is_deployed.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/tiller_is_deployed.rego \
  --from-file=policy.uses_image_tag_latest.rego=$DEFSEC_DIR/rules/kubernetes/policies/general/uses_image_tag_latest.rego \
  --from-file=policy.capabilities_no_drop_at_least_one.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/capabilities_no_drop_at_least_one.rego \
  --from-file=policy.manages_etc_hosts.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/manages_etc_hosts.rego \
  --from-file=policy.protect_core_components_namespace.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/protect_core_components_namespace.rego \
  --from-file=policy.protecting_pod_service_account_tokens.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/protecting_pod_service_account_tokens.rego \
  --from-file=policy.selector_usage_in_network_policies.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/selector_usage_in_network_policies.rego \
  --from-file=policy.uses_untrusted_azure_registry.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/uses_untrusted_azure_registry.rego \
  --from-file=policy.uses_untrusted_gcr_registry.rego=$DEFSEC_DIR/rules/kubernetes/policies/advanced/uses_untrusted_gcr_registry.rego \
  --from-file=policy.1_host_ipc.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/1_host_ipc.rego \
  --from-file=policy.1_host_network.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/1_host_network.rego \
  --from-file=policy.1_host_pid.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/1_host_pid.rego \
  --from-file=policy.2_privileged.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/2_privileged.rego \
  --from-file=policy.3_specific_capabilities_added.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/3_specific_capabilities_added.rego \
  --from-file=policy.4_hostpath_volumes_mounted.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/4_hostpath_volumes_mounted.rego \
  --from-file=policy.5_access_to_host_ports.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/5_access_to_host_ports.rego \
  --from-file=policy.6_apparmor_policy_disabled.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/6_apparmor_policy_disabled.rego \
  --from-file=policy.7_selinux_custom_options_set.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/7_selinux_custom_options_set.rego \
  --from-file=policy.8_non_default_proc_masks_set.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/8_non_default_proc_masks_set.rego \
  --from-file=policy.9_unsafe_sysctl_options_set.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/baseline/9_unsafe_sysctl_options_set.rego \
  --from-file=policy.1_non_core_volume_types.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/restricted/1_non_core_volume_types.rego \
  --from-file=policy.2_can_elevate_its_own_privileges.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/restricted/2_can_elevate_its_own_privileges.rego \
  --from-file=policy.3_runs_as_root.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/restricted/3_runs_as_root.rego \
  --from-file=policy.4_runs_with_a_root_gid.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/restricted/4_runs_with_a_root_gid.rego \
  --from-file=policy.5_runtime_default_seccomp_profile_not_set.rego=$DEFSEC_DIR/rules/kubernetes/policies/pss/restricted/5_runtime_default_seccomp_profile_not_set.rego \
  --from-literal=policy.CPU_not_limited.kinds=Workload \
  --from-literal=policy.CPU_requests_not_specified.kinds=Workload \
  --from-literal=policy.SYS_ADMIN_capability.kinds=Workload \
  --from-literal=policy.capabilities_no_drop_all.kinds=Workload \
  --from-literal=policy.file_system_not_read_only.kinds=Workload \
  --from-literal=policy.memory_not_limited.kinds=Workload \
  --from-literal=policy.memory_requests_not_specified.kinds=Workload \
  --from-literal=policy.mounts_docker_socket.kinds=Workload \
  --from-literal=policy.runs_with_GID_le_10000.kinds=Workload \
  --from-literal=policy.runs_with_UID_le_10000.kinds=Workload \
  --from-literal=policy.tiller_is_deployed.kinds=Workload \
  --from-literal=policy.uses_image_tag_latest.kinds=Workload \
  --from-literal=policy.capabilities_no_drop_at_least_one.kinds=Workload \
  --from-literal=policy.manages_etc_hosts.kinds=Workload \
  --from-literal=policy.protect_core_components_namespace.kinds=Workload \
  --from-literal=policy.protecting_pod_service_account_tokens.kinds=Workload \
  --from-literal=policy.selector_usage_in_network_policies.kinds=NetworkPolicy \
  --from-literal=policy.uses_untrusted_azure_registry.kinds=Workload \
  --from-literal=policy.uses_untrusted_gcr_registry.kinds=Workload \
  --from-literal=policy.1_host_ipc.kinds=Workload \
  --from-literal=policy.1_host_network.kinds=Workload \
  --from-literal=policy.1_host_pid.kinds=Workload \
  --from-literal=policy.2_privileged.kinds=Workload \
  --from-literal=policy.3_specific_capabilities_added.kinds=Workload \
  --from-literal=policy.4_hostpath_volumes_mounted.kinds=Workload \
  --from-literal=policy.5_access_to_host_ports.kinds=Workload \
  --from-literal=policy.6_apparmor_policy_disabled.kinds=Workload \
  --from-literal=policy.7_selinux_custom_options_set.kinds=Workload \
  --from-literal=policy.8_non_default_proc_masks_set.kinds=Workload \
  --from-literal=policy.9_unsafe_sysctl_options_set.kinds=Workload \
  --from-literal=policy.1_non_core_volume_types.kinds=Workload \
  --from-literal=policy.2_can_elevate_its_own_privileges.kinds=Workload \
  --from-literal=policy.3_runs_as_root.kinds=Workload \
  --from-literal=policy.4_runs_with_a_root_gid.kinds=Workload \
  --from-literal=policy.5_runtime_default_seccomp_profile_not_set.kinds=Workload \
  --dry-run=client -o yaml > $SCRIPT_ROOT/deploy/static/05-starboard-operator.policies.yaml