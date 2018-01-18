From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [spi:topic/a3700 4/4] drivers/spi/spi-armada-3700.c:759:33: sparse:
 incorrect type in assignment (different base types)
Date: Thu, 18 Jan 2018 23:55:12 +0800
Message-ID: <201801182310.i21tIBzi%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git topic/a3700
head:   f68a7dcb91b7957c5bb1c3e347775332af719519
commit: f68a7dcb91b7957c5bb1c3e347775332af719519 [4/4] spi: a3700: Add full-duplex support
reproduce:
        # apt-get install sparse
        git checkout f68a7dcb91b7957c5bb1c3e347775332af719519
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/spi/spi-armada-3700.c:496:21: sparse: incorrect type in assignment (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/spi/spi-armada-3700.c:496:21: expected unsigned int val
   drivers/spi/spi-armada-3700.c:496:21: got restricted __le32 <noident>
   drivers/spi/spi-armada-3700.c:519:36: sparse: cast to restricted __le32
>> drivers/spi/spi-armada-3700.c:759:33: sparse: incorrect type in assignment (different base types) @@ expected unsigned int val_out @@ got igned] val_out @@
   drivers/spi/spi-armada-3700.c:759:33: expected unsigned int val_out
   drivers/spi/spi-armada-3700.c:759:33: got restricted __le32 <noident>
   drivers/spi/spi-armada-3700.c:768:26: sparse: cast to restricted __le32

vim +759 drivers/spi/spi-armada-3700.c

   737	
   738	static int a3700_spi_transfer_one_full_duplex(struct spi_master *master,
   739					  struct spi_device *spi,
   740					  struct spi_transfer *xfer)
   741	{
   742		struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
   743		u32 val_in, val_out;
   744	
   745		/* Disable FIFO mode */
   746		a3700_spi_fifo_mode_set(a3700_spi, false);
   747	
   748		while (a3700_spi->buf_len) {
   749	
   750			/* When we have less than 4 bytes to transfer, switch to 1 byte
   751			 * mode. This is reset after each transfer
   752			 */
   753			if (a3700_spi->buf_len < 4)
   754				a3700_spi_bytelen_set(a3700_spi, 1);
   755	
   756			if (a3700_spi->byte_len == 1)
   757				val_out = *a3700_spi->tx_buf;
   758			else
 > 759				val_out = cpu_to_le32(*(u32 *)a3700_spi->tx_buf);
   760	
   761			spireg_write(a3700_spi, A3700_SPI_DATA_OUT_REG, val_out);
   762	
   763			/* Wait for all the data to be shifted in / out */
   764			while (!(spireg_read(a3700_spi, A3700_SPI_IF_CTRL_REG) &
   765					A3700_SPI_XFER_DONE))
   766				cpu_relax();
   767	
   768			val_in = le32_to_cpu(spireg_read(a3700_spi,
   769							 A3700_SPI_DATA_IN_REG));
   770	
   771			memcpy(a3700_spi->rx_buf, &val_in, a3700_spi->byte_len);
   772	
   773			a3700_spi->buf_len -= a3700_spi->byte_len;
   774			a3700_spi->tx_buf += a3700_spi->byte_len;
   775			a3700_spi->rx_buf += a3700_spi->byte_len;
   776	
   777		}
   778	
   779		spi_finalize_current_transfer(master);
   780	
   781		return 0;
   782	}
   783	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
