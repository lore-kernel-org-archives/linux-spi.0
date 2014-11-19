From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v3 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Wed, 19 Nov 2014 11:53:44 +0200
Message-ID: <20141119095343.GD2583@lpalcu-linux>
References: <1416312599-5176-1-git-send-email-laurentiu.palcu@intel.com>
 <1416312599-5176-2-git-send-email-laurentiu.palcu@intel.com>
 <20141118170627.GB22786@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Octavian Purdila <octavian.purdila@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118170627.GB22786@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 18, 2014 at 06:06:27PM +0100, Johan Hovold wrote:
> On Tue, Nov 18, 2014 at 02:09:58PM +0200, Laurentiu Palcu wrote:
> 
> > +/*
> > + * Copy the data to DLN2 buffer and change the byte order to LE, requested by
> > + * DLN2 module. SPI core makes sure that the data length is a multiple of word
> > + * size.
> > + */
> > +static int dln2_spi_copy_to_buf(u8 *dln2_buf, const u8 *src, u16 len, u8 bpw)
> > +{
> > +#ifdef __LITTLE_ENDIAN
> > +	memcpy(dln2_buf, src, len);
> > +#else
> > +	if (bpw <= 8) {
> > +		memcpy(dln2_buf, src, len);
> > +	} else if (bpw <= 16) {
> > +		__le16 *d = (__le16 *)dln2_buf;
> > +		u16 *s = (u16 *)src;
> > +
> > +		len = len / 2;
> > +		while (len--)
> > +			put_unaligned_le16(get_unaligned(s++), d++);
> 
> You said the dln2 buffer was properly aligned, right? Then you don't
> need to use put_unaligned_lexx here...
I know, and I was very close not to use it, but, as you said, others
might not be as careful and if Diolan FW changes anything in the
header's structure in the future, the alignment will be off. This is
just a precaution. I know it's a little bit costly but this will affect
only BE machines and only if bits-per-word is bigger than 8.

> 
> > +	} else {
> > +		__le32 *d = (__le32 *)dln2_buf;
> > +		u32 *s = (u32 *)src;
> > +
> > +		len = len / 4;
> > +		while (len--)
> > +			put_unaligned_le32(get_unaligned(s++), d++);
> > +	}
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Copy the data from DLN2 buffer and convert to CPU byte order since the DLN2
> > + * buffer is LE ordered. SPI core makes sure that the data length is a multiple
> > + * of word size.
> > + */
> > +static int dln2_spi_copy_from_buf(u8 *dest, const u8 *dln2_buf, u16 len, u8 bpw)
> > +{
> > +#ifdef __LITTLE_ENDIAN
> > +	memcpy(dest, dln2_buf, len);
> > +#else
> > +	if (bpw <= 8) {
> > +		memcpy(dest, dln2_buf, len);
> > +	} else if (bpw <= 16) {
> > +		u16 *d = (u16 *)dest;
> > +		__le16 *s = (__le16 *)dln2_buf;
> > +
> > +		len = len / 2;
> > +		while (len--)
> > +			put_unaligned(get_unaligned_le16(s++), d++)
> 
> ...or get_unaligned_lexx here.
> 
> > +	} else {
> > +		u32 *d = (u32 *)dest;
> > +		__le32 *s = (__le32 *)dln2_buf;
> > +
> > +		len = len / 4;
> > +		while (len--)
> > +			put_unaligned(get_unaligned_le32(s++), d++)
> > +	}
> > +#endif
> > +
> > +	return 0;
> > +}
> 
> Did you check the alignment of the SPI buffers as well? I'd assume they
> were DMA-able and thus properly aligned, and then you do not need to use
> any unaligned helpers above at all.
I did... The spi_transfer struct documentation says that those tx_buf
and rx_buf buffers are dma-safe but, apparently, I found drivers that do
not really use alligned buffers for transfers. Look, for example, at
max1111.c. Those buffers don't look aligned to me... Well, this driver
is probably not the best example since BPW is 8, but you got my point.
Other drivers, indeed, use the ____cacheline_aligned attribute and
should be dma-safe.

laurentiu
