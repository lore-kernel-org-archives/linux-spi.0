From: "=?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=" <gotzoncabanes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI in IXP4XX
Date: Fri, 21 Nov 2008 09:03:14 +0100
Message-ID: <b0438a630811210003v4d81c9d4g33c851f489c1743f@mail.gmail.com>
References: <b0438a630811120424j76289a0ag8cb9e72bc30ff11f@mail.gmail.com>
	<200811201256.44429.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200811201256.44429.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, Nov 20, 2008 at 9:56 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 12 November 2008, Miguel =C1ngel =C1lvarez wrote:
>> Hi
>>
>> I have used PXA2XX code to implement SPI in IXP4XX. SPI in both of
>> them is implemented using an SSP controller. My questions are:
>>
>> - Should I comment my changes in this list, or just in the linux-arm lis=
t?
>
> SPI code --> SPI list.  CC the ARM list if you like.
>
Thanks. That is also my point of view.
>
>> - SSP code for the PXA2XX is placed inside its own arch directories.
>> Could it be useful to move it into the SPI directories?
>
> Eventually the mach-pxa/*ssp*c code should vanish.
>
Vanish? Into what? Who is working on it, and how can I help him
introduce my modifications for ixp4xx?

Thanks

Miguel =C1ngel =C1lvarez

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
