From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Patch 3/4] ST LIS3L02DQ accelerometer
Date: Wed, 23 Jul 2008 18:07:26 +0100
Message-ID: <20080723180726.6fc0ef6e@lxorguk.ukuu.org.uk>
References: <488763AD.4050400@gmail.com>
	<488766F4.20603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Dmitry Torokhov <dtor@mail.ru>,
	"Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br,
	David Brownell <david-b@pacbell.net>, mgross@linux.intel.com,
	Ben Nizette <bn@niasdigital.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754933AbYGWRyU@vger.kernel.org>
In-Reply-To: <488766F4.20603@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> +	xfer.tx_buf = kmalloc(4, GFP_KERNEL);
> +	if (xfer.tx_buf == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	xfer.rx_buf = kmalloc(4, GFP_KERNEL);
> +	if (xfer.rx_buf == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_tx;
> +	}

Do these really need to be two kmallocs

> +	if (ret) {
> +		dev_err(&st->us->dev, "problem with get x offset");
> +		goto error_free_rx;
> +	}
> +	*val = ((unsigned char *)(xfer.rx_buf))[0];
> +	kfree(xfer.rx_buf);
> +	kfree(xfer.tx_buf);
> +	return ret;
> +error_free_rx:
> +	kfree(xfer.rx_buf);
> +error_free_tx:
> +	kfree(xfer.tx_buf);
> +error_ret:
> +	return ret;

That lot makes no sense. You could just drop through..

> +{
> +	uint8_t val;
> +	int8_t ret;

Kernel types (u8, s8 etc)

>
> +	local_rx_buf = kmalloc(4, GFP_KERNEL);
> +	local_tx_buf = kmalloc(4, GFP_KERNEL);
> +
> +	local_tx_buf[1] = LIS3L02DQ_READ_REG(reg_address);

OOPS on out of memory case


> +	struct spi_transfer xfer = {
> +		.tx_buf = NULL,
> +		.rx_buf = NULL,
> +		.bits_per_word = 16,
> +		.len = 2,
> +	};
> +	int ret;
> +
> +	local_tx_buf = kmalloc(4, GFP_KERNEL);
> +	if (local_tx_buf == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	xfer.tx_buf = local_tx_buf;

You seem to have a lot of almost identical routines here. It looks like
with a few helpers this driver could be vastly shorter.
