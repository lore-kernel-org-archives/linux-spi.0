From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: Fix device unregistration when unregistering the
	bus master
Date: Tue, 6 Dec 2011 20:32:53 +0100
Message-ID: <CACRpkda685p+fe_P5Ww=4Qtup6qmCe_oqiwTqN+KAaAktPNKFw@mail.gmail.com>
References: <1322486604-27808-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<CACRpkdZf0pcdJyh2Th=KbrcCa=D-aqCiMCNoCmPGQo3iFZpsdg@mail.gmail.com>
	<201112061722.48910.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201112061722.48910.laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 6, 2011 at 5:22 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> Hi Linus,
>> The latter should be:
>>
>> =A0 =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev =3D master->dev;
>>
>> Just my =800.01...
>
> I agree with you, that was my initial approach as well. However, it chang=
es
> the parent-child relationships and might break applications relying on th=
at
> relationship in sysfs for instance. Would that be acceptable ?

In my experience people use the /sys/class/* interfaces and don't
traverse hierarchies much.

But I'm not to speak about such things...

I would have put the patch in and see if somebody screams ...

Linus Walleij

---------------------------------------------------------------------------=
---
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point o=
f =

discussion for anyone considering optimizing the pricing and packaging mode=
l =

of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
