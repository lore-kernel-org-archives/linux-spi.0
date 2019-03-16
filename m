From: kbuild test robot <lkp@intel.com>
Subject: [spi:for-5.2 8/8] drivers/spi/spi-stm32-qspi.c:520:1: sparse: symbol
 'stm32_qspi_pm_ops' was not declared. Should it be static?
Date: Sat, 16 Mar 2019 15:33:40 +0800
Message-ID: <201903161509.ZfXt4Lx6%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Ludovic Barre <ludovic.barre@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2
head:   2e541b64ee5269278fde5c87953a9963a8219ed4
commit: 2e541b64ee5269278fde5c87953a9963a8219ed4 [8/8] spi: spi-mem: stm32-qspi: add suspend/resume support
reproduce:
        # apt-get install sparse
        git checkout 2e541b64ee5269278fde5c87953a9963a8219ed4
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-stm32-qspi.c:520:1: sparse: symbol 'stm32_qspi_pm_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
