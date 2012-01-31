From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
Date: Tue, 31 Jan 2012 14:59:14 -0700
Message-ID: <CACxGe6vsW6u5s26vat=M4J-+39NK5L=ccydQaVkGHYZpeV=gOw@mail.gmail.com>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
	<1328019048-5892-10-git-send-email-florian@openwrt.org>
	<20120131201922.GE22611@ponder.secretlab.ca>
	<201201312220.41561.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201201312220.41561.florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 31, 2012 at 2:20 PM, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wro=
te:
> On Tuesday 31 January 2012 21:19:22 Grant Likely wrote:
>> > +static const struct dev_pm_ops bcm63xx_spi_pm_ops =3D {
>> > + =A0 .suspend =A0 =A0 =A0 =A0=3D bcm63xx_spi_suspend,
>> > + =A0 .resume =A0 =A0 =A0 =A0 =3D bcm63xx_spi_resume,
>> > +};
>> > +
>> > +#define BCM63XX_SPI_PM_OPS (&bcm63xx_spi_pm_ops)
>> > +#else
>> > +#define BCM63XX_SPI_PM_OPS NULL
>>
>> A bit ugly. =A0Do this instead in the else clause and drop the
>> BCM63XX_SPI_PM_OPS:
>>
>> #define bcm63xx_spi_pm_ops NULL
>
> This won't work, because driver.pm must be set to a pointer to a struct
> dev_pm_ops, that's why I used this trick to make it build fine in both ca=
ses.
> If I follow your advice, with driver.pm =3D &bcm63xx_spi_pm_ops, it won't=
 build
> for CONFIG_PM=3Dn.

Okay, fair enough.

g.

---------------------------------------------------------------------------=
---
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
