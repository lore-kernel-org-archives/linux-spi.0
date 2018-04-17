From: kbuild test robot <lkp@intel.com>
Subject: [spi:for-4.18 12/12] drivers/spi/spi-pxa2xx.c:914:5: sparse: symbol
 'pxa2xx_spi_transfer_one' was not declared. Should it be static?
Date: Wed, 18 Apr 2018 03:53:23 +0800
Message-ID: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-4.18
head:   d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1
commit: d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1 [12/12] spi: pxa2xx: Use core message processing loop
reproduce:
        # apt-get install sparse
        git checkout d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/spi/spi-pxa2xx.c:877:16: sparse: expression using sizeof(void)
   drivers/spi/spi-pxa2xx.c:877:16: sparse: expression using sizeof(void)
>> drivers/spi/spi-pxa2xx.c:914:5: sparse: symbol 'pxa2xx_spi_transfer_one' was not declared. Should it be static?
   drivers/spi/spi-pxa2xx.c:1672:42: sparse: expression using sizeof(void)
   drivers/spi/spi-pxa2xx.c:1672:42: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
