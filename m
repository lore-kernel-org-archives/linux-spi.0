From: "=?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=" <gotzoncabanes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI in IXP4XX
Date: Fri, 21 Nov 2008 10:29:09 +0100
Message-ID: <b0438a630811210129y2d517f12n43e9b11da726af55@mail.gmail.com>
References: <b0438a630811120424j76289a0ag8cb9e72bc30ff11f@mail.gmail.com>
	<200811201256.44429.david-b@pacbell.net>
	<b0438a630811210003v4d81c9d4g33c851f489c1743f@mail.gmail.com>
	<200811210048.28842.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200811210048.28842.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi

On Fri, Nov 21, 2008 at 9:48 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Friday 21 November 2008, Miguel =C1ngel =C1lvarez wrote:
>> > Eventually the mach-pxa/*ssp*c code should vanish.
>> >
>> Vanish? Into what?
>
> It's basically a nonstandard SPI interface; so, into
> the standard interface.
>
> (Of course SSP can be used for stuff that's not SPI.
> Like I2S, in sound/soc ...)
>
>
>> Who is working on it, and how can I help him
>> introduce my modifications for ixp4xx?
>
> I don't know that anyone is working on it.  Which is
> why I said "eventually".
>

So... Returning to the main question. I have code for using SSP and
SPI in IXP4XX, and it is based in the PXA2XX. The main problem is that
I do not want to add whole new files for what is clearly just a
modification. However the original code is not accesible because it is
in the mach-pxa2xx directories.

Which decision should I take so that my changes have greater chances
of been accepted? Moving the files of pxa2xx or creating new ones? Or
this is just a bad decision and I should not use the code of pxa2xx at
all?

Thanks

Miguel =C1ngel

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
