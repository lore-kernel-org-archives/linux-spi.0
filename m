From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Tue, 5 Nov 2019 11:05:05 +0000
Message-ID: <20191105110504.GA4500@sirena.co.uk>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
 <1572886297-45400-3-git-send-email-john.garry@huawei.com>
 <20191104192406.GH5238@sirena.co.uk>
 <855a67dc-1356-a763-e374-540f6ac400ab@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com
To: John Garry <john.garry@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <855a67dc-1356-a763-e374-540f6ac400ab@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2019 at 10:58:39AM +0000, John Garry wrote:
> On 04/11/2019 19:24, Mark Brown wrote:
> > On Tue, Nov 05, 2019 at 12:51:36AM +0800, John Garry wrote:

> > > +		if (len) {
> > > +			u32 val;
> > > +
> > > +			val = __raw_readl(host->regbase + CMD_DATABUF(words));
> > > +
> > > +			to += words * 4;
> > > +			for (i = 0; i < len; i++, val >>= 8, to++)
> > > +				*to = (u8)val;
> > > +		}
> > > +	} else {
> > > +		for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
> > > +			u32 val = __raw_readl(host->regbase + CMD_DATABUF(i));
> > > +			int j;

> > The more usual pattern for these would be to do some unaligned accesses
> > for the start/end of the buffer to get to alignment and then transfer
> > the rest as aligned data.

> Yeah, I understand you, but for that I would need to generate multiple
> transactions in the driver, and I wanted to keep 1x transaction per
> spi_controller_mem_ops.exec_op call.

> So maybe I can do some trickery in my adjust_op_size method to generate
> these multiple transactions: a. any unaligned start data b. the 32b-aligned
> data b. unaligned end. I think that the HW should be able to handle that.

Right, that's what I was expecting.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3BV14ACgkQJNaLcl1U
h9BKZAf6Ash1CMprp9CmtoZgXDlZGjI+I84fZ7x4ZvMSHOMZ20e7KMwVEKBJ4UH8
onKbrC/sLhV9dOTh4KdW9H7QnPp7NQPru6ZartbDCKHDT2wT7SJCXlQWapZrg5Gh
E/xH29aG6yQrIxTvYtsqNjBw7cheRBDQUTAvMH+rqNMLtOQVnWgh+Tf09izlS1ve
6vJrCROj/xO319Oc2iAhRGRbXgr++392iYarO3qdad6SSGFZFVKCs9lU/U+9I8Dz
KG2nKTMal8tnwJw4GRJ5PqPVsrs3+UYJwey6mbPVeIXfp1Oe2H8igZmXdmd4o9F2
OHTRDQDXOG8K/Opk2MV79xBmKG+pKw==
=S6Z7
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
