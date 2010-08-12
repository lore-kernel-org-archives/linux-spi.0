From: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: add spi_tegra driver
Date: Thu, 12 Aug 2010 11:44:33 -0700
Message-ID: <AANLkTik+OyBJ5RYjfsoxEfBLdYO=y1nOVDmec2bpz+Wv@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<AANLkTimUm_wj+gyxTa=X+845kLj1sZ9GF+jsmsBwxnLN@mail.gmail.com>
	<AANLkTinKNfPtaYYyUMmdTRewSKiRnTEfaf+pKkx_7jME@mail.gmail.com>
	<20100812152424.GB31982@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100812152424.GB31982-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 12, 2010 at 8:24 AM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Wed, Aug 11, 2010 at 05:31:00PM -0700, Erik Gilling wrote:
>> >> + =A0 =A0 =A0 if (!request_mem_region(r->start, (r->end - r->start) +=
 1,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pdev->dev))) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> >> + =A0 =A0 =A0 }
>> >
>> > I believe the platform bus does this for you already by calling
>> > insert_resource() on all the platform bus ranges. =A0See if /proc/iomem
>> > is any different with or without this call to verify.
>>
>> You're right. =A0Didn't realize this
>
> There is a big difference between what the platform bus does and what
> drivers do.
>
> The platform bus adds the resources to the resource tree as they stand
> without marking them _busy_. =A0This means that they can be sub-divided
> and other resources registered within their range.
>
> request_mem_region() adds resources to the resource tree marking them
> busy, detecting overlapping resources and indicating whether two
> drivers are trying to claim the same resource region. =A0In other words,
> it's a preventative measure against two device drivers accessing the
> same region.
>
> You're absolutely right to do what you're doing above, please continue
> to do so.
>

Thanks for the explanation. I'll add it back in.

Cheers,
    Erik

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
