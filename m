From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Wed, 19 Nov 2014 14:51:21 +0100
Message-ID: <20141119135121.GF7857@localhost>
References: <1416394031-2663-1-git-send-email-laurentiu.palcu@intel.com>
 <1416402467-26999-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416402467-26999-1-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 19, 2014 at 03:07:47PM +0200, Laurentiu Palcu wrote:

> +/*
> + * Perform one read operation.
> + */
> +static int dln2_spi_read_one(struct dln2_spi *dln2, u8 *data,
> +			     u16 data_len, u8 attr)
> +{
> +	int ret;
> +	struct {
> +		u8 port;
> +		__le16 size;
> +		u8 attr;
> +	} __packed tx;
> +	struct {
> +		__le16 size;
> +		u8 buf[DLN2_SPI_MAX_XFER_SIZE];
> +	} __packed *rx = dln2->buf;

You said you verified that the dln2 protocol headers did not mess up the
alignment, yet they do. Here you have a two byte header.

> +	unsigned rx_len = sizeof(*rx);
> +
> +	BUILD_BUG_ON(sizeof(*rx) > DLN2_SPI_BUF_SIZE);
> +
> +	if (data_len > DLN2_SPI_MAX_XFER_SIZE)
> +		return -EINVAL;
> +
> +	tx.port = dln2->port;
> +	tx.size = cpu_to_le16(data_len);
> +	tx.attr = attr;
> +
> +	ret = dln2_transfer(dln2->pdev, DLN2_SPI_READ, &tx, sizeof(tx),
> +			    rx, &rx_len);
> +	if (ret < 0)
> +		return ret;
> +	if (rx_len < sizeof(rx->size) + data_len)
> +		return -EPROTO;
> +	if (le16_to_cpu(rx->size) != data_len)
> +		return -EPROTO;
> +
> +	dln2_spi_copy_from_buf(data, rx->buf, data_len, dln2->bpw);

So you need to use the unaligned macros in dln2_spi_copy_from_buf for
rx->buf (at least for bpw 32).

Make sure to document why.

> +
> +	return 0;
> +}
> +
> +/*
> + * Perform one write & read operation.
> + */
> +static int dln2_spi_read_write_one(struct dln2_spi *dln2, const u8 *tx_data,
> +				   u8 *rx_data, u16 data_len, u8 attr)
> +{
> +	int ret;
> +	struct {
> +		u8 port;
> +		__le16 size;
> +		u8 attr;
> +		u8 buf[DLN2_SPI_MAX_XFER_SIZE];
> +	} __packed *tx;

tx is ok.

> +	struct {
> +		__le16 size;
> +		u8 buf[DLN2_SPI_MAX_XFER_SIZE];
> +	} __packed *rx;

But here you have the same two-byte header.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
