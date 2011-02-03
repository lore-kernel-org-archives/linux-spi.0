From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v4] spi: add OpenCores tiny SPI driver
Date: Thu, 03 Feb 2011 07:20:32 -0800
Message-ID: <4D4AC7C0.4050608@gmail.com>
References: <1295925450-28550-1-git-send-email-thomas@wytron.com.tw> <1296729466-2936-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	nios2-dev@sopc.et.ntust.edu.tw,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Thomas Chou <thomas@wytron.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296729466-2936-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/03/2011 02:37 AM, Thomas Chou wrote:
> This patch adds support of OpenCores tiny SPI driver.
>
> http://opencores.org/project,tiny_spi
>

> +static int tiny_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct tiny_spi *hw = tiny_spi_to_hw(spi);
> +	const u8 *txp = t->tx_buf;
> +	u8 *rxp = t->rx_buf;
> +	unsigned int i;
> +
> +	if (hw->irq>= 0) {
> +		/* use intrrupt driven data transfer */
> +		hw->len = t->len;
> +		hw->txp = t->tx_buf;
> +		hw->rxp = t->rx_buf;
> +		hw->txc = 0;
> +		hw->rxc = 0;
> +
> +		/* send the first byte */
> +		if (t->len>  1) {
> +			writeb(hw->txp ? *hw->txp++ : 0,
> +			       hw->base + TINY_SPI_TXDATA);
> +			hw->txc++;
> +			writeb(hw->txp ? *hw->txp++ : 0,
> +			       hw->base + TINY_SPI_TXDATA);
> +			hw->txc++;
> +			writeb(TINY_SPI_STATUS_TXR, hw->base + TINY_SPI_STATUS);
> +		} else {
> +			writeb(hw->txp ? *hw->txp++ : 0,
> +			       hw->base + TINY_SPI_TXDATA);
> +			hw->txc++;
> +			writeb(TINY_SPI_STATUS_TXE, hw->base + TINY_SPI_STATUS);
> +		}
> +
> +		wait_for_completion(&hw->done);
> +	} else if (txp&&  rxp) {
> +		/* we need to tighten the transfer loop */
> +		writeb(*txp++, hw->base + TINY_SPI_TXDATA);
> +		if (t->len>  1) {
> +			writeb(*txp++, hw->base + TINY_SPI_TXDATA);
> +			for (i = 2; i<  t->len; i++) {
> +				u8 rx, tx = *txp++;
> +				while (!(readb(hw->base + TINY_SPI_STATUS)&
> +					 TINY_SPI_STATUS_TXR))
> +					cpu_relax();

Putting the read status, cpu releax in an inline function would make this 
function a lot easier to read.

> +				rx = readb(hw->base + TINY_SPI_TXDATA);
> +				writeb(tx, hw->base + TINY_SPI_TXDATA);
> +				*rxp++ = rx;
> +			}
> +			while (!(readb(hw->base + TINY_SPI_STATUS)&
> +				 TINY_SPI_STATUS_TXR))
> +				cpu_relax();
> +			*rxp++ = readb(hw->base + TINY_SPI_TXDATA);
> +		}
> +		while (!(readb(hw->base + TINY_SPI_STATUS)&
> +			 TINY_SPI_STATUS_TXE))
> +			cpu_relax();
> +		*rxp++ = readb(hw->base + TINY_SPI_RXDATA);
> +	} else if (rxp) {
> +		writeb(0, hw->base + TINY_SPI_TXDATA);
> +		if (t->len>  1) {
> +			writeb(0,
> +			       hw->base + TINY_SPI_TXDATA);
> +			for (i = 2; i<  t->len; i++) {
> +				u8 rx;
> +				while (!(readb(hw->base + TINY_SPI_STATUS)&
> +					 TINY_SPI_STATUS_TXR))
> +					cpu_relax();
> +				rx = readb(hw->base + TINY_SPI_TXDATA);
> +				writeb(0,
> +				       hw->base + TINY_SPI_TXDATA);
> +				*rxp++ = rx;
> +			}
> +			while (!(readb(hw->base + TINY_SPI_STATUS)&
> +				 TINY_SPI_STATUS_TXR))
> +				cpu_relax();
> +			*rxp++ = readb(hw->base + TINY_SPI_TXDATA);
> +		}
> +		while (!(readb(hw->base + TINY_SPI_STATUS)&
> +			 TINY_SPI_STATUS_TXE))
> +			cpu_relax();
> +		*rxp++ = readb(hw->base + TINY_SPI_RXDATA);
> +	} else if (txp) {
> +		writeb(*txp++, hw->base + TINY_SPI_TXDATA);
> +		if (t->len>  1) {
> +			writeb(*txp++, hw->base + TINY_SPI_TXDATA);
> +			for (i = 2; i<  t->len; i++) {
> +				u8 tx = *txp++;
> +				while (!(readb(hw->base + TINY_SPI_STATUS)&
> +					 TINY_SPI_STATUS_TXR))
> +					cpu_relax();
> +				writeb(tx, hw->base + TINY_SPI_TXDATA);
> +			}
> +		}
> +		while (!(readb(hw->base + TINY_SPI_STATUS)&
> +			 TINY_SPI_STATUS_TXE))
> +			cpu_relax();
> +	} else {
> +		writeb(0, hw->base + TINY_SPI_TXDATA);
> +		if (t->len>  1) {
> +			writeb(0,
> +			       hw->base + TINY_SPI_TXDATA);
> +			for (i = 2; i<  t->len; i++) {
> +				while (!(readb(hw->base + TINY_SPI_STATUS)&
> +					 TINY_SPI_STATUS_TXR))
> +					cpu_relax();
> +				writeb(0,
> +				       hw->base + TINY_SPI_TXDATA);
> +			}
> +		}
> +		while (!(readb(hw->base + TINY_SPI_STATUS)&
> +			 TINY_SPI_STATUS_TXE))
> +			cpu_relax();
> +	}
> +	return t->len;
> +}
