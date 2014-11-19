From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Wed, 19 Nov 2014 16:12:40 +0200
Message-ID: <20141119141239.GE2583@lpalcu-linux>
References: <1416394031-2663-1-git-send-email-laurentiu.palcu@intel.com>
 <1416402467-26999-1-git-send-email-laurentiu.palcu@intel.com>
 <20141119135121.GF7857@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141119135121.GF7857@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 19, 2014 at 02:51:21PM +0100, Johan Hovold wrote:
> On Wed, Nov 19, 2014 at 03:07:47PM +0200, Laurentiu Palcu wrote:
> 
> > +/*
> > + * Perform one read operation.
> > + */
> > +static int dln2_spi_read_one(struct dln2_spi *dln2, u8 *data,
> > +			     u16 data_len, u8 attr)
> > +{
> > +	int ret;
> > +	struct {
> > +		u8 port;
> > +		__le16 size;
> > +		u8 attr;
> > +	} __packed tx;
> > +	struct {
> > +		__le16 size;
> > +		u8 buf[DLN2_SPI_MAX_XFER_SIZE];
> > +	} __packed *rx = dln2->buf;
> 
> You said you verified that the dln2 protocol headers did not mess up the
> alignment, yet they do. Here you have a two byte header.
I did, only that I mistakenly counted the entire header, including
dln2_response struct size, which is 10 bytes... :/

thanks,
laurentiu

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
