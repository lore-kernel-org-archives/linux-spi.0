From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: Fix device unregistration when unregistering the
	bus master
Date: Tue, 6 Dec 2011 17:22:48 +0100
Message-ID: <201112061722.48910.laurent.pinchart@ideasonboard.com>
References: <1322486604-27808-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<CACRpkdZf0pcdJyh2Th=KbrcCa=D-aqCiMCNoCmPGQo3iFZpsdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdZf0pcdJyh2Th=KbrcCa=D-aqCiMCNoCmPGQo3iFZpsdg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

On Friday 02 December 2011 13:14:31 Linus Walleij wrote:
> On Mon, Nov 28, 2011 at 2:23 PM, Laurent Pinchart wrote:
> > I'm not too familiar with the way the SPI subsystem plugs its devices in
> > the Linux device model, so I'm not sure what the right fix is. An
> > alternative would be to register the SPI devices as children of the SPI
> > master, not as siblings.
> =

> I think that is actually the right solution, so the bug is in
> spi_alloc_device() where it sets:
> =

>         struct spi_device       *spi;
>         struct device           *dev =3D master->dev.parent;
> =

> The latter should be:
> =

>         struct device           *dev =3D master->dev;
> =

> Just my =800.01...

I agree with you, that was my initial approach as well. However, it changes =

the parent-child relationships and might break applications relying on that =

relationship in sysfs for instance. Would that be acceptable ?

-- =

Regards,

Laurent Pinchart

---------------------------------------------------------------------------=
---
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point o=
f =

discussion for anyone considering optimizing the pricing and packaging mode=
l =

of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
