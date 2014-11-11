From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH 2/2] mfd: dln2: add support for USB-SPI module
Date: Tue, 11 Nov 2014 15:09:04 +0200
Message-ID: <20141111130904.GN5826@lpalcu-linux>
References: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
 <1415364314-30320-3-git-send-email-laurentiu.palcu@intel.com>
 <20141110093005.GF21424@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Johan Havold <johan@kernel.org>,
	Octavian Purdila <octavian.purdila@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141110093005.GF21424@x1>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lee,

On Mon, Nov 10, 2014 at 09:30:05AM +0000, Lee Jones wrote:
> On Fri, 07 Nov 2014, Laurentiu Palcu wrote:
>=20
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
> > ---
> >  drivers/mfd/dln2.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > index 9765a17..0cdad2d 100644
> > --- a/drivers/mfd/dln2.c
> > +++ b/drivers/mfd/dln2.c
> > @@ -52,6 +52,7 @@ enum dln2_handle {
> >  	DLN2_HANDLE_CTRL,
> >  	DLN2_HANDLE_GPIO,
> >  	DLN2_HANDLE_I2C,
> > +	DLN2_HANDLE_SPI,
> >  	DLN2_HANDLES
> >  };
> > =20
> > @@ -634,6 +635,12 @@ static struct dln2_platform_data dln2_pdata_i2=
c =3D {
> >  	.port =3D 0,
> >  };
> > =20
> > +/* Only one SPI port supported */
> > +static struct dln2_platform_data dln2_pdata_spi =3D {
>=20
> Is this ever fiddled with?  If not, const?
Well, if we declare this const we also need to cast the assignment belo=
w to
void* since platform_data is void*. Otherwise we get a "assignment
discards =E2=80=98const=E2=80=99 qualifier from pointer target type" wa=
rning.=20

Also, for consistency, we have to do it for all dln2_pdata_*. I'm not
sure it's worth it...

laurentiu

>=20
> > +	.handle =3D DLN2_HANDLE_SPI,
> > +	.port =3D 0,
> > +};
> > +
> >  static const struct mfd_cell dln2_devs[] =3D {
> >  	{
> >  		.name =3D "dln2-gpio",
> > @@ -645,6 +652,11 @@ static const struct mfd_cell dln2_devs[] =3D {
> >  		.platform_data =3D &dln2_pdata_i2c,
> >  		.pdata_size =3D sizeof(struct dln2_platform_data),
> >  	},
> > +	{
> > +		.name =3D "dln2-spi",
> > +		.platform_data =3D &dln2_pdata_spi,
> > +		.pdata_size =3D sizeof(struct dln2_platform_data),
> > +	},
> >  };
> > =20
> >  static void dln2_disconnect(struct usb_interface *interface)
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
