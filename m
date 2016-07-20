From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [lkp] [PATCH v3 1/3] spi: spidev: create spidev device for all
 spi slaves.
Date: Wed, 20 Jul 2016 15:16:47 +0800
Message-ID: <20160720071647.GH10855@wfg-t540p.sh.intel.com>
References: <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2xzXx3ruJf7hsAzo"
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

[auto build test WARNING on v4.7-rc7]
[cannot apply to next-20160719]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michal-Suchanek/Spidev-usability-patchset-update/20160720-055513
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

    include/linux/init.h:1: warning: no structured comments found
    kernel/sched/core.c:2081: warning: No description found for parameter 'cookie'
    kernel/sys.c:1: warning: no structured comments found
    drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'spidev_devt'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'spidev'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'spidev_lock'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'buf_lock'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'spidev_users'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'tx_buffer'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'rx_buffer'
>> include/linux/spi/spi.h:195: warning: No description found for parameter 'spidev_speed_hz'

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 2797999799fc3b7f10f680b3e3fa34ca56e1385d
vim +/spidev_devt +195 include/linux/spi/spi.h

33e34dc6 David Brownell  2007-05-08  179  	 *  - ...
33e34dc6 David Brownell  2007-05-08  180  	 */
27979997 Michal Suchanek 2016-07-19  181  
27979997 Michal Suchanek 2016-07-19  182  	/* spidev stuff */
27979997 Michal Suchanek 2016-07-19  183  #if config_enabled(CONFIG_SPI_SPIDEV)
27979997 Michal Suchanek 2016-07-19  184  	dev_t                   spidev_devt;
27979997 Michal Suchanek 2016-07-19  185  	struct device *		spidev;
27979997 Michal Suchanek 2016-07-19  186  	spinlock_t              spidev_lock;
27979997 Michal Suchanek 2016-07-19  187  
27979997 Michal Suchanek 2016-07-19  188  	/* TX/RX buffers are NULL unless this device is open (users > 0) */
27979997 Michal Suchanek 2016-07-19  189  	struct mutex            buf_lock;
27979997 Michal Suchanek 2016-07-19  190  	unsigned                spidev_users;
27979997 Michal Suchanek 2016-07-19  191  	u8                      *tx_buffer;
27979997 Michal Suchanek 2016-07-19  192  	u8                      *rx_buffer;
27979997 Michal Suchanek 2016-07-19  193  	u32                     spidev_speed_hz;
27979997 Michal Suchanek 2016-07-19  194  #endif /*CONFIG_SPI_SPIDEV*/
8ae12a0d David Brownell  2006-01-08 @195  };
8ae12a0d David Brownell  2006-01-08  196  
8ae12a0d David Brownell  2006-01-08  197  static inline struct spi_device *to_spi_device(struct device *dev)
8ae12a0d David Brownell  2006-01-08  198  {
b885244e David Brownell  2006-01-08  199  	return dev ? container_of(dev, struct spi_device, dev) : NULL;
8ae12a0d David Brownell  2006-01-08  200  }
8ae12a0d David Brownell  2006-01-08  201  
8ae12a0d David Brownell  2006-01-08  202  /* most drivers won't need to care about device refcounting */
8ae12a0d David Brownell  2006-01-08  203  static inline struct spi_device *spi_dev_get(struct spi_device *spi)



---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--2xzXx3ruJf7hsAzo
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2xzXx3ruJf7hsAzo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
