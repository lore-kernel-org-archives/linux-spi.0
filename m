From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Mon, 19 Apr 2010 13:05:55 -0600
Message-ID: <j2hfa686aa41004191205jf61e53ectc994ab0e5a2c4c53@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
	<o2g56d259a01004191152w9c2245fdgaa2d4ac1b9e95ed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <o2g56d259a01004191152w9c2245fdgaa2d4ac1b9e95ed7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 19, 2010 at 12:52 PM, Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 4/19/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> =A0>> > + =A0 =A0 =A0 /*
>> =A0>> > + =A0 =A0 =A0 =A0* Calculate divisors so that we can get speed a=
ccording the
>> =A0>> > + =A0 =A0 =A0 =A0* following formula:
>> =A0>> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0rate =3D spi_clock_rate / (cpsr * =
(1 + scr))
>> =A0>> > + =A0 =A0 =A0 =A0*
>> =A0>> > + =A0 =A0 =A0 =A0* cpsr must be even number and starts from 2, s=
cr can be any number
>> =A0>> > + =A0 =A0 =A0 =A0* between 0 and 255.
>> =A0>> > + =A0 =A0 =A0 =A0*/
>> =A0>> > + =A0 =A0 =A0 for (cpsr =3D 2; cpsr <=3D 254; cpsr +=3D 2) {
>> =A0>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (scr =3D 0; scr <=3D 255; scr+=
+) {
>> =A0>>
>> =A0>> Non-deterministic.
> Eh? Some new meaning of "non-deterministic" that I wasn'f familiar with? =
:)
>
> Yes, it does look gross, but max clock rate is 3.7Mhz (7.4 in rev E2
> silicon), so if your slowest device is 400kHz, in practice it only
> runs the inner loop from 0 to less than 10.
> How slow do SPI devices go in reality? The 254*256 divisor gives 100Hz.

Fair enough.  s/non-deterministic/gross/  :-p  I just prefer to see
analytic solutions over numerical ones.  :-)  As I said, I won't
object to the driver because of these lines.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
