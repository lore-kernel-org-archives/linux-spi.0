From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Sat, 25 Aug 2018 13:21:25 +0800
Message-ID: <201808251010.KRlMjZ8C%fengguang.wu@intel.com>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, swboyd@chromium.org, broonie@kernel.org,
        mka@chromium.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Girish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on spi/for-next]
[also build test ERROR on v4.18]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dilip-Kota/spi-spi-geni-qcom-Add-SPI-driver-support-for-GENI-based-QUP/20180824-190528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-allmodconfig
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        make ARCH=i386  allmodconfig
        make ARCH=i386 

All errors (new ones prefixed by >>):


vim +239 drivers/spi/spi-geni-qcom.c

   212	
   213	static int spi_geni_prepare_transfer_hardware(struct spi_master *spi)
   214	{
   215		struct spi_geni_master *mas = spi_master_get_devdata(spi);
   216		struct geni_se *se = &mas->se;
   217	
   218		if (!mas->setup) {
   219			unsigned int proto = geni_se_read_proto(se);
   220			unsigned int major, minor, step, ver;
   221	
   222			if (proto != GENI_SE_SPI) {
   223				dev_err(mas->dev, "Invalid proto %d\n", proto);
   224				return -ENXIO;
   225			}
   226			mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
   227			mas->rx_fifo_depth = geni_se_get_rx_fifo_depth(se);
   228			mas->tx_fifo_width = geni_se_get_tx_fifo_width(se);
   229	
   230			/*
   231			 * Hardware programming guide suggests to configure
   232			 * RX FIFO RFR level to fifo_depth-2.
   233			 */
   234			geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
   235			mas->oversampling = 1;
   236			/* Transmit an entire FIFO worth of data per IRQ */
   237			mas->tx_wm = 1;
   238			ver = geni_se_get_qup_hw_version(se);
 > 239			major = GENI_SE_VERSION_MAJOR(ver);
 > 240			minor = GENI_SE_VERSION_MINOR(ver);
 > 241			step = GENI_SE_VERSION_STEP(ver);
   242	
   243			if (major == 1 && minor == 0)
   244				mas->oversampling = 2;
   245			mas->setup = 1;
   246		}
   247		return 0;
   248	}
   249	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
