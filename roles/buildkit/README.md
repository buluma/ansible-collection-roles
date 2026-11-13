# [Ansible role buildkit](#ansible-role-buildkit)

Install and Configure buildkit on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-buildkit/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-buildkit/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-buildkit.svg)](https://github.com/buluma/ansible-role-buildkit/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-buildkit.svg)](https://github.com/buluma/ansible-role-buildkit/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-buildkit.svg)](https://github.com/buluma/ansible-role-buildkit/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/buildkit)](https://galaxy.ansible.com/ui/standalone/roles/buluma/buildkit/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-buildkit/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.buildkit
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-buildkit/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.ca_certificates
    - role: andrewrothstein.unarchivedeps
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-buildkit/blob/master/defaults/main.yml):

```yaml
---
buildkit_apps:
  - buildctl
  - buildkitd
  - buildkit-runc
buildkit_arch_map:
  aarch64: arm64
  arm64: arm64
  armv7: arm-v7
  ppc64le: ppc64le
  s390x: s390x
  x86_64: amd64
buildkit_checksums:
  0.10.0:
    darwin-amd64: sha256:f80a3726d1ad662e573b9eab5a00cb82b07ab44ea5ba871a755f64fff41fe9c5
    darwin-arm64: sha256:1729c99674e319d2501ae9df541532061e9923d470c49415181231c2f626102f
    linux-amd64: sha256:ed9d3942ca3f1cbc4906577a2422e5084416dd2739f3d85b800a129d61557630
    linux-arm-v7: sha256:c51b0ae0cbbef201f6ee50d9111993f9b3069c74ec56e66166178f2fbabb486d
    linux-arm64: sha256:f201c30dca4877eca9598ae41c1c8934c98b37a9ad323cec8b30ce9138f957ac
    linux-ppc64le: sha256:0a116cc167db07a27aa4c013f7284f51d7707fa1d2cf2dcc0ca1d73a396edeec
    linux-riscv64: sha256:a6975c7d988986d04ca78d2cf63eaa463859976a65edc281edcc0d6cc5182be7
    linux-s390x: sha256:44c86494a73356a250a2808946929a02f53563cd2d5afc4c05a6619756c1bd0e
    windows-amd64: sha256:0f6a272e9cf40e499d4d9d9a21b41bb5ad3393cb3406c1bf76e36f5e9a3942ef
    windows-arm64: sha256:237e79fb684f8a40b92b3a721ab79a19f452dff451bf5f23cf0865e296985035
  0.10.1:
    darwin-amd64: sha256:19fe16ea13605295d21b9a6d4d206bebfb7cc0bd4463ed75eeaee178ff443fe7
    darwin-arm64: sha256:ce9ad65be7956cd372711cc7e000fb1d6de4294fd767c7a04c795bd2356063a7
    linux-amd64: sha256:14d1e0cd76167dae24232bb336384e770aa7c91819df69922e0d3c0d54ddb8de
    linux-arm-v7: sha256:818ada4226f86699b35bcdad4c42162c8ce54d4caea0f10c66a604d2d8333196
    linux-arm64: sha256:6f38143ae782db1123d61421114ae7b035878115cab181af6625efe2d5c24bf8
    linux-ppc64le: sha256:f47a406673d5a443517992b5612ef601d5f04abcdd1eb16396efe0a0a0998955
    linux-riscv64: sha256:c8ac3666ac547fa1422b464667e32d8c898f5960ba3e05007011a571872ceebb
    linux-s390x: sha256:5229766f01fb1672ebc7b6c15ee4f5f555d4e01328f41a739ef6fa0e47f0cf84
    windows-amd64: sha256:fe85d744ed6fa03dd038cee1d74288b73cbdfd5d3b96795ae35783c1294b0bb3
    windows-arm64: sha256:ca58d47c4ba2856ae61a265db369e39d0cd788d6e144bbc6622cfef270469895
  0.10.2:
    darwin-amd64: sha256:f3739f67366e0f42e59491201a645263985206dda0e9e09bf626443b9ac4b9b1
    darwin-arm64: sha256:22cb34b8d058b6fd8d44518da514d9ec1f129f0b09f6aac62774b4b078dadcad
    linux-amd64: sha256:ce330ab4e1d6543fec0e62d724d361dddfcfb6dcd9ef992e0e6a498a1865f51f
    linux-arm-v7: sha256:59e6374ec269749f1ee07f02cb73be7aea3e960fdb8c1304e59847b556e8b2c0
    linux-arm64: sha256:a0e419dd3e87fa7833043e01dca588ee022e1fcbeb925e9198e9ccca090d44f9
    linux-ppc64le: sha256:a1d989fbe67aa193c8348a6d6ad4b6ab7939440fa8efcf16097087d41fd5c4c6
    linux-riscv64: sha256:48bd0d22a2412cc521f8eda2ab5325b3b66209ac387cbaf8bc9e29f188a851bb
    linux-s390x: sha256:765eb0755272ca35b3a04e36075307526140da3f06db3a57b6c02b76efa4aeb0
    windows-amd64: sha256:274dd34ba0f79fb6c6d0089f1f6a593603e5e7224d203447c5e94a478d2a8020
    windows-arm64: sha256:ab879ea3ebcf86d88cf8bf72f61c69cef00c9ad5be36de49e51cd9da156d8c38
  0.10.3:
    darwin-amd64: sha256:180c77274251ef9c1a287a5e24a441acdb7634f7f59cb9e2cb9851852fed97b8
    darwin-arm64: sha256:7fe8afd99a5fbb20385cac48a59414caba395fa23e5183d72a472debc07946ad
    linux-amd64: sha256:fbc9c433cf77c5c00db6f797155edc60b44463524ae59a4961699dca15bcee00
    linux-arm-v7: sha256:0f3fde02b70aff791caeeb5c3f84e58b2b1c8d71685289fe89013f204de44be8
    linux-arm64: sha256:27e974e2b07e087f66f0c9c2b43b6f3df6f7e1746a6252580f164427337d668c
    linux-ppc64le: sha256:fa9d15c1e7d78a3ac27becd4e48d349ce42275f2faae1b4bf99be4c76a113a3b
    linux-riscv64: sha256:d215679b1fa2898baf940119990316d6320690cef2ae33e4880bfc0dbec86192
    linux-s390x: sha256:01638582765558c2f281b453a1c794f10b6ce6848847e25dde62072cf097fb5d
    windows-amd64: sha256:0e6bab044aec84959842c00f09c5ca5ec6ccf642167082849e2d7a2fe4856553
    windows-arm64: sha256:b269b2440d397faf201078e31ef1d52020ea358d6a3a053da8d938eca05300ab
  0.10.4:
    darwin-amd64: sha256:7e93848b9fe1776ca264a2f4a402ad01186f73bfe4ca59e279fb5190c11ed1c0
    darwin-arm64: sha256:3921dd464eb90d9f4f84f80ac1e74499fc77099dc263c7a16a285c2e095becde
    linux-amd64: sha256:b9bfbdc116ff51ce13378a614c945752f8b53f7bb08434f620ae0237f3c1ac30
    linux-arm-v7: sha256:769320575ebdcec465b29b52c075a99c0431b8c3d4c1f2c1249fe90f86275dda
    linux-arm64: sha256:16e09545cba03c7edd509b3a6692b1c61ad36baf4791d2adb148ed87d26afa9e
    linux-ppc64le: sha256:0b1b388f3415bd2acf3be48d89f2acddc94c1bc880cdfa7665c3b8c7ae8d5463
    linux-riscv64: sha256:407b9f2d242bedfb0d3888ce70a80a70e4791e0ee91ac1df1c93fa57c9be539f
    linux-s390x: sha256:9c6b3158cbd42830806fc4fd6cb35be7d2c81246deaf5308238d5ee029c1bbc9
    windows-amd64: sha256:ff3ebebe3f2b85bd5d33273455ff23375a1bb8048804af7c54cd8a21777a0008
    windows-arm64: sha256:0d46d81def55874cd3eb07221e299cef738b1c4527ce570fe1abdc5cfbca4225
  0.10.5:
    darwin-amd64: sha256:182fe8841a4c225aa22f70f6fc9f2dc360194b588ee32b376acecc394062c3a9
    darwin-arm64: sha256:4d5a4ccb2fdfda14c3aa77bb4edb19ea90693c697813fd2600a5115b97887c28
    linux-amd64: sha256:bb811495555e40b993b57f9af67825b0437f8b5606de92b7aba828b41651ccc6
    linux-arm-v7: sha256:1aaea408243f7ca3f68787e2248dc5caf922432b81b1e89792b753819c53e18d
    linux-arm64: sha256:010a60a4f4e0e07b07acd5c75c06c5bc1b9504dafbb8660ea1e2ec45479099d4
    linux-ppc64le: sha256:e2d31b56476cfeae163ea81f3de8b1e4886756069fc052022afa015d7c04e5fa
    linux-riscv64: sha256:43dd87334fbee7057f2086982c8f9c0e21193f45301a9f2c69e934096de62fbd
    linux-s390x: sha256:b13123943ba2dc4eef555a86e5ccbcab0e17530cce24bc52100bcfeb3baf2c0f
    windows-amd64: sha256:2d837557730cee6a2287f6905a6ebb88a31598a7b993a3bebf4471b8e35b13e0
    windows-arm64: sha256:bbec3733f06a11cc2e31bc942b271c66417e958c7a465d26a01462e0848fd90c
  0.10.6:
    darwin-amd64: sha256:3ffcb3910b337ce74868c36f1fef6ef4c0b32f7f16f54e9acd004ce2f3ae5bd2
    darwin-arm64: sha256:eaad6698b4013e67290fe3515888916b8ea99aa86d296af8d7bcb61da8e95ec5
    linux-amd64: sha256:9a21a41298c4a2a7a2b57cb90d37463d3a9057aedfe97a04b0e4fd6f622549d8
    linux-arm-v7: sha256:f0f13245eac7713ce1585df544e478090b7162b577edff80665ca1f6185be795
    linux-arm64: sha256:e0d5533808f3c0cb57ad26b8fd962566625b35b0921a46df91980d6f0a78fd10
    linux-ppc64le: sha256:cd3f29ca1b1927e62ef4d6b4e434926e459b3a0e64d4160fb3c58416433ec8aa
    linux-riscv64: sha256:f92aaf67321b16c91f96f37f649e573709be584118df98712653f8a6b155c96f
    linux-s390x: sha256:d5eac5c1b3b3f18f2ef3a0b4369500f5acc4a18695fcc50756b49a9363aa2520
    windows-amd64: sha256:6095f8f8fab13f3c9cb1df4c63e4160cd092041d70358a9ee2b56db95bd7d1ef
    windows-arm64: sha256:12501809a28efd244c1b465fca29ad96e22e35dcb4a9951242d3712375f78c46
  0.11.0:
    darwin-amd64: sha256:35090b0fbcaee922e52a0860a45be2b2484299df5242e70546fc6599c7c5cf86
    darwin-arm64: sha256:a802a01fdd3aecbaf5f898ff33860fcf9865226ce84005ed4b5e968bdc2f2194
    linux-amd64: sha256:d60fe269b03e6ecf73ea4525b9d9ae2734e0846d55a037bc03eb570a1571e63f
    linux-arm-v7: sha256:7375919dde4dfef1c24b4c48eb053c2421758ddd3d3fce8cda9cd685aff3806d
    linux-arm64: sha256:ea1f10c7a7f0ddab94ba840fb24d30fa2f5093cc3f822d24e3ee7e324a566e2d
    linux-ppc64le: sha256:b9e969e91035f4ceb24aae4b60a6464e905b524452b745e6bb897940f5c5df71
    linux-riscv64: sha256:700f0bcfaac92cc4f613a02b20c4388605da809dc897b8ca0d82bb0f68acd9b7
    linux-s390x: sha256:015a1319a34a9a5967236f5649703cc5c701e397db2ea1f8f9aa5d2b47fc5451
    windows-amd64: sha256:2cbc8c90a53ce47d9f2157d57d483af7c04701c3408893856432b2a7492a1505
    windows-arm64: sha256:3c0fdcdad49251e6ab840983d2e62b064e4712d4078875ae193ddfbe85c7f084
  0.11.1:
    darwin-amd64: sha256:bdf0aec8ce655a1075ab5708a0e2b44b69615673c07337e8b62e501a6f8547ed
    darwin-arm64: sha256:42bef34d56c088a526d4e0e30435ab73aede5a3bb3aa216b50ecdc11cf97bafd
    linux-amd64: sha256:db8d1cebd05451de02838a41d22b8df86a252fc9bfce7673150176d9fc03bcfa
    linux-arm-v7: sha256:3f66a48628667afa930484ecc4e913dcd320acd7bdc38794a30946d056eb0259
    linux-arm64: sha256:f16fcedd5b4d332ce7bce2637af51e064338299c07a1438ec5c7401aaf4cb2b9
    linux-ppc64le: sha256:6b97d2ac714f9ff2f20c2468bd64f1fc47bf708da10d35cfa353d849c851e9dd
    linux-riscv64: sha256:2037f9f5c95d7fdce8739ae46af693c99c140e4b02963728988fdd00c8131899
    linux-s390x: sha256:88308a60b1ad20080d474ac95d1fa305446cfe892ee86677a927ee7b3119f9cd
    windows-amd64: sha256:11eebbef33011fcb0a3607199679914d1ed39f1400fb86116ec4ab12fdfb7546
    windows-arm64: sha256:00b333297c3fbb4e6c66d89099990237a43c3f895d24e507f9fff89bced5ad39
  0.11.2:
    darwin-amd64: sha256:bf0f536f8ec775392ed7542acaf5390496e6d931df6758a17f341d595e0c7691
    darwin-arm64: sha256:7606f2aee4898170edfeee0ea0044cd99905f480a84b8c621f878bb9493d4f09
    linux-amd64: sha256:6d0fe3f1ec2dce4ed2a5c9baf05fb279225b3b0e3bbee4092304fe284ca7fc47
    linux-arm-v7: sha256:620ed04246266a949464e151ed7eafdf78ac11f5ac2994c2b234707abc03afcd
    linux-arm64: sha256:8a8c2274852ea4bac6ccf1862a46679e93c013de8c5c0434a3040bab2e0a42a7
    linux-ppc64le: sha256:585358a1ebd588a394b0164098adfc733b5d3a2f5e4b5a02257f115176b0ee4c
    linux-riscv64: sha256:a22967f677d20f81dd0680bd3bf526f775efe631459feb022f37c69e11e758a1
    linux-s390x: sha256:5111ac71ad336fd520e94af4e557729b686759327b0e2c41a342b0f79df6c176
    windows-amd64: sha256:209adb8c0b9799b3591c596b9fdb0297cd0c1db3e1d829e109a0cefd39138c34
    windows-arm64: sha256:f33e9a06c4a47d3e239fa1fd350ad714b3515e690642000eced0b1b0e344f079
  0.11.3:
    darwin-amd64: sha256:cc87d6ee6d8e2f1b110124e2548b29efebd85b4759cd8b3f9c2e87d1c6a52f57
    darwin-arm64: sha256:1c58bf0a6d0853d57fae79c429b512f0e3a149933e87e76dbe6d16c82eb91f5c
    linux-amd64: sha256:f631978dc283670500a602df1ba1a49333af137c0792716c5510d3cbb9cb4ede
    linux-arm-v7: sha256:78c4d445f6926c8e162ba0ce4b02d1a8d2cf31bcf97ccbf4ba9d9ab8deb6173f
    linux-arm64: sha256:3425ebba8ff0748e2a26dc9f45a879a03bde0937c6acbbc8e6659b905d014f07
    linux-ppc64le: sha256:2cbf651c627f75c3c7ce4895c72e1971fbf03954084ce8b99e9e0bccfe8abe97
    linux-riscv64: sha256:756bf42ac86900078c37ea6533e48fa1bc923d9f66900e93a9c0ddf542eb1f11
    linux-s390x: sha256:ac93e634cb8d680cad755ff110ee43d51d03d1f07fd6843d37dcdb10afc22e32
    windows-amd64: sha256:5a7397940297b0eddf30ea314ba4ac5bd87fba028d1e139afc063a256eee9c0d
    windows-arm64: sha256:0a02c2b336cdfa1dc633e1646ff9b276c233ba87b6506c812edc792d041535cc
  0.11.4:
    darwin-amd64: sha256:f4a98d540ca536eb91cac9e5300105c2a6279ae60d87008c058317963a02d397
    darwin-arm64: sha256:8d1f9ac7c1f25b9c41bfdc4e8db7ab441cdc000fa3e2eae6684acbb378909eb6
    linux-amd64: sha256:6de87c88b1da0b1e899371dd4c0b883581401e2ddfb21a065510eeb3a8ac8743
    linux-arm-v7: sha256:f65e373663d72f7d4f3569881e4a59fe4ff6b89bf8835f7653180d348e5ed46f
    linux-arm64: sha256:252408105ef1c2256980a105f727912603a831d6c57d3243b5d4cbb25fafb1b1
    linux-ppc64le: sha256:4ed011d1ef80622df3b6c4dd12c42133334df15729af9f9d562ba53343c80154
    linux-riscv64: sha256:936006b61ac602fcb94498e172b9b0e37e8bcbad6a7561587d347d614328c1e3
    linux-s390x: sha256:7bacfcac0a6b5c656b06fa6683e8bff0d5aa3eee7b92ad7e0052e804b12bff08
    windows-amd64: sha256:15ee12c1d0ec08707dc503618a69eb6788547d328533c8c356ff5a9836027424
    windows-arm64: sha256:068e197518fe3f5afb993674d67e72ac09fdb03933681b3dd3743dfa33b835c4
  0.11.5:
    darwin-amd64: sha256:8ba5ff9f7000015c140cc118ccda492d2da96b42c9db9c8139cb8b02acc56d72
    darwin-arm64: sha256:9ce054c1a06b754a61fbcd84f277e15435726ab2ca221e6246f86170e9829869
    linux-amd64: sha256:ce40cd62645772059f402b97fc4b89890a2382202bed5e48a316729d73dc1b42
    linux-arm-v7: sha256:63712dea4030ebb5d1c2fed79b8f5913012f92acabd75b1964dd18ac7662068c
    linux-arm64: sha256:31e5d1a259f56ca55e4c36566531d7ab5401f62902408baede8e9c43160d3925
    linux-ppc64le: sha256:36828cf43976b81910a7547116af7583dfd19d96d176b9c4cd7acf9b5c579f7a
    linux-riscv64: sha256:516d06ae8a598f728c4fbb0e69e0b0240e5454acf7474fcc754f814201981935
    linux-s390x: sha256:d5c7078a32befe06769332926a719a69e9bcdb8e5e8b4c3e87544f1c076bb0a1
    windows-amd64: sha256:71e2aee41c049cbe79ab3ed01aa5b89b288600de4bcf8c2a5e80e32f76762bee
    windows-arm64: sha256:72b44b197e1819a71fcde55a39ff46d6550490b2b83f3fa9c9b14f555d858add
  0.12.3:
    darwin-amd64: sha256:69bdc457de9f0411f911dc58c0ff136c064a43131c828e44405547b399042b49
    darwin-arm64: sha256:b0619f243832bb46a0c4928ea0025db4e6ab651332f108eab17821c20a5740cd
    linux-amd64: sha256:01682ab9e8e7cada519396b5f7b72c964c0c30da0c2eb7ee46caf30622717fa1
    linux-arm-v7: sha256:72ba1cb5af5ce3ae93be71a92c5a9341877aa0daccb16e43b85ea934f983eaa3
    linux-arm64: sha256:a6809c7983834f5a4dd3a92a421a9ff9a306e774ce2866d53636e8d5a3f2e82b
    linux-ppc64le: sha256:babe0f35855812ab9b77bc775966a704e4ddc9808ce6acd2e0fe793b7a9d182a
    linux-riscv64: sha256:a2d0f13e3bd1e1b3ab34e7f4fb6567c48d07f4d990204e80dd8a1643184f65a5
    linux-s390x: sha256:8ec91b81fa46ab2b0713ccdd949fac870d38806b8d0e612a28dd270ddf7dd246
    windows-amd64: sha256:97a071d8e9e02a93e4cced8a00331a5fd39e945cbb41f8286ffbc0ea722ddaa3
    windows-arm64: sha256:86da06dfa277114d041368188a3cc863db2d10e75b20417cb2996e7016ae25fd
  0.12.4:
    darwin-amd64: sha256:57d5d4e6075842dac8bf6cc86a792242678a16860172a2da91a7fcb8aad93d7a
    darwin-arm64: sha256:3c3c36dcb07063fef1c8b52faeb22bfd28f9f5dd1cf141b56d18073f8127de77
    linux-amd64: sha256:75ffe406e4284b77af35447d829767cfa935eb7dd2ea2e3407223d6885bd8ebd
    linux-arm-v7: sha256:08736cd760435691efe54238c8938473024ef017f47169e9933ac8b89c348567
    linux-arm64: sha256:9166eeaff11721122b9398d6385c7b73d6e4df86797e537c16ac6b6d05eab899
    linux-ppc64le: sha256:8a3640bcb277a0f1499a9e988c530902c358beb8ff2a27aa355906ea02ad5eb1
    linux-riscv64: sha256:abefa2fccc8a59175cbd5e1a144501752bdb0ae0994398d35c709b7eaedc76b9
    linux-s390x: sha256:85ab9d94f37ee34310cbe990e760f1f39ad8bc06d62b57fc33cc8e76130dc0e5
    windows-amd64: sha256:189a398b604261f1b6fd3efb3e84f08f1f5253a5016534e08381caf041771d8e
    windows-arm64: sha256:f9fb5569a3d833b8ac2cde7ce4713cdf10e17f88ca0c51aefa4da5029d88df53
  0.8.3:
    darwin-amd64: sha256:31469477bc8feaa9f6d7a3ebbad732a1973ec7c2b76bba0cc8941687a0b401d0
    linux-amd64: sha256:1e5cf4cd6cf2645575c74f385d6ca2ba51c622bf0217f48af9ab0fbcd9432161
    linux-arm-v7: sha256:9df1886e0d7b3074496055cfcbf634e643ce28ed0427abe2a8ca92363737f0b3
    linux-arm64: sha256:61f0369ec7593b4b493a32c1d2c7845a183cf6891489cfc882eeccec75c3ad1e
    linux-ppc64le: sha256:736cf8d827d19e7b47eb893fe0d11d4796848f517b2a25baf73a487aa8597846
    linux-s390x: sha256:11bbc051d161e51c862f6d351625d27831229a3e20be7e138fa8eaf3711000c8
    windows-amd64: sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
  0.9.0:
    darwin-amd64: sha256:4212f97475317f50d2721924c388c35b7a451ad20b4382997bd4e6870eff1095
    linux-amd64: sha256:1b307268735c8f8e68b55781a6f4c03af38acc1bc29ba39ebaec6d422bccfb25
    linux-arm-v7: sha256:d631578d3e83127d10fe1667b5ed7f92b6a9b6a45490deb4cdb986fcc848f915
    linux-arm64: sha256:0a834a749e86525e0eb16e7e80ce726e7c6a8e8d26fc5cc36c712305024da4e7
    linux-ppc64le: sha256:4ef64c2b0897899cf571f28c8664ae45013070437093ff07e320c2c8d82b07a8
    linux-s390x: sha256:cc283531ae650b112e60107e28b75443a01edc88968996d5bafecf9769f4333e
    windows-amd64: sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
  0.9.1:
    darwin-amd64: sha256:488148cb50b25595436ce6ef535bbf98ba1d0eb5eeb53c5cf94aea88a811a308
    linux-amd64: sha256:f5c82431fb9e672e1f900b5623433fb4d477e80e16ca4c836d42594312e927a2
    linux-arm-v7: sha256:e84244c85d9e202bae7f892de0a9a1e224b80486c2764e808cd9fa728f520dad
    linux-arm64: sha256:e780b0df9a279463feab8f587c9b7fee3f79f68f6c698bac0e51252a750e7f98
    linux-ppc64le: sha256:dc104a275183b08e4f12991ba16c35920d8d87d9b5426e9c45eba3989aaa2c32
    linux-s390x: sha256:6db7d286927e99b2cdf081d43bd9f0f02c3df14a5891cb3666d3daaacb277cb6
    windows-amd64: sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
  0.9.2:
    darwin-amd64: sha256:b5c20bc6a4ff553a2829249e08938ebb54dd1c986bb082f2b8fc234102a813f8
    linux-amd64: sha256:931d8bb6b461a396c54ed2ce4fa48a2d5eafeb6985a97823e39e549bc89bec27
    linux-arm-v7: sha256:92bb4eafdae4bdd18e70aad55243c53879b5857790b9c80bdcbde8d569020490
    linux-arm64: sha256:d97d1e0380d715777875b3acf5b7d2d67b715b983b4827a385eb99f372f9538d
    linux-ppc64le: sha256:bb22dca8c9c833dca8f72732b42d09dde5144dd86bb219d86781628682114746
    linux-s390x: sha256:3eaa45c988499aa305b7b2238c05587861b8007901b7c9ffcfee749cd1da1e81
  0.9.3:
    darwin-amd64: sha256:0f5e72298682529a35c16256b192b56faeac2b4cc5786998fa55eebe9335e677
    linux-amd64: sha256:f60461abdf2aee8444a4cb0607e4766da3bd503859320819ea8c43fe4a02576c
    linux-arm-v7: sha256:8864eecbc03b0c97e9f40c73fe2dc1541dcecf9fe68d3f4bbb3c7912294484e1
    linux-arm64: sha256:3ee57ac33f8ff6ab1d187e25a217f8f2358826b14d707fd8fe0df6f536613aaf
    linux-ppc64le: sha256:1186cadd403d2da5c759de465ce6a1626f9f98bc83d320361dba55c4c749f23d
    linux-s390x: sha256:156bdc7282f07848257d464f39c0665334246ce7e57d82d02048f85883fa8018
    windows-amd64: sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
buildkit_mirror: "https://github.com/moby/buildkit/releases/download"
buildkit_parent_install_dir: /usr/local
buildkit_qemu_architectures:
  - aarch64
  - x86_64
  - arm
  - i386
  - ppc64le
  - riscv64
  - s390x
buildkit_ver: "0.34.1"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-buildkit/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|
|[andrewrothstein.unarchivedeps](https://galaxy.ansible.com/buluma/andrewrothstein.unarchivedeps)|[![Build Status GitHub](https://github.com/buluma/andrewrothstein.unarchivedeps/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/andrewrothstein.unarchivedeps/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-buildkit/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-buildkit/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-buildkit/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
