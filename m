From: kbuild test robot <lkp@intel.com>
Subject: [spi:for-5.2 11/19] drivers/spi/spi-fsl-lpspi.c:483:5: sparse:
 symbol 'fsl_lpspi_runtime_resume' was not declared. Should it be static?
Date: Tue, 19 Mar 2019 09:46:33 +0800
Message-ID: <201903190907.mIc3klXH%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <frank.li@nxp.com>, linux-kernel@vger.kernel.org
To: Han Xu <han.xu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2
head:   69b921acae8a5b7feef03921d9b42c3634f3b9d1
commit: 944c01a889d97dc08e1b71f4ed868f4023fd6034 [11/19] spi: lpspi: enable runtime pm for lpspi
reproduce:
        # apt-get install sparse
        git checkout 944c01a889d97dc08e1b71f4ed868f4023fd6034
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-fsl-lpspi.c:483:5: sparse: symbol 'fsl_lpspi_runtime_resume' was not declared. Should it be static?
>> drivers/spi/spi-fsl-lpspi.c:501:5: sparse: symbol 'fsl_lpspi_runtime_suspend' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
