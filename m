From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Tue, 18 Nov 2014 18:06:27 +0100
Message-ID: <20141118170627.GB22786@localhost>
References: <1416312599-5176-1-git-send-email-laurentiu.palcu@intel.com>
 <1416312599-5176-2-git-send-email-laurentiu.palcu@intel.com>
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
In-Reply-To: <1416312599-5176-2-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Nov 18, 2014 at 02:09:58PM +0200, Laurentiu Palcu wrote:

> +/*
> + * Copy the data to DLN2 buffer and change the byte order to LE, requested by
> + * DLN2 module. SPI core makes sure that the data length is a multiple of word
> + * size.
> + */
> +static int dln2_spi_copy_to_buf(u8 *dln2_buf, const u8 *src, u16 len, u8 bpw)
> +{
> +#ifdef __LITTLE_ENDIAN
> +	memcpy(dln2_buf, src, len);
> +#else
> +	if (bpw <= 8) {
> +		memcpy(dln2_buf, src, len);
> +	} else if (bpw <= 16) {
> +		__le16 *d = (__le16 *)dln2_buf;
> +		u16 *s = (u16 *)src;
> +
> +		len = len / 2;
> +		while (len--)
> +			put_unaligned_le16(get_unaligned(s++), d++);

You said the dln2 buffer was properly aligned, right? Then you don't
need to use put_unaligned_lexx here...

> +	} else {
> +		__le32 *d = (__le32 *)dln2_buf;
> +		u32 *s = (u32 *)src;
> +
> +		len = len / 4;
> +		while (len--)
> +			put_unaligned_le32(get_unaligned(s++), d++);
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy the data from DLN2 buffer and convert to CPU byte order since the DLN2
> + * buffer is LE ordered. SPI core makes sure that the data length is a multiple
> + * of word size.
> + */
> +static int dln2_spi_copy_from_buf(u8 *dest, const u8 *dln2_buf, u16 len, u8 bpw)
> +{
> +#ifdef __LITTLE_ENDIAN
> +	memcpy(dest, dln2_buf, len);
> +#else
> +	if (bpw <= 8) {
> +		memcpy(dest, dln2_buf, len);
> +	} else if (bpw <= 16) {
> +		u16 *d = (u16 *)dest;
> +		__le16 *s = (__le16 *)dln2_buf;
> +
> +		len = len / 2;
> +		while (len--)
> +			put_unaligned(get_unaligned_le16(s++), d++)

...or get_unaligned_lexx here.

> +	} else {
> +		u32 *d = (u32 *)dest;
> +		__le32 *s = (__le32 *)dln2_buf;
> +
> +		len = len / 4;
> +		while (len--)
> +			put_unaligned(get_unaligned_le32(s++), d++)
> +	}
> +#endif
> +
> +	return 0;
> +}

Did you check the alignment of the SPI buffers as well? I'd assume they
were DMA-able and thus properly aligned, and then you do not need to use
any unaligned helpers above at all.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
