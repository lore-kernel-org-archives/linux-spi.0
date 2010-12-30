From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/9] spi/pxa2xx: register driver properly
Date: Wed, 29 Dec 2010 17:55:30 -0800 (PST)
Message-ID: <27128.99950.qm@web180304.mail.gq1.yahoo.com>
References: <20101229214054.GB15198@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101229214054.GB15198-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



--- On Wed, 12/29/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Subject: Re: [PATCH 1/9] spi/pxa2xx: register

> > >I detect an effort to change the classic model for
> board initialization in Linux:=A0 first set up
> > >and register all system/platform devices on each board then do the sam=
e for their drivers.=A0
> ("hardware first" ... "software second".
> > =

> > What are you suggesting? =


Just what I said above.   The classic model
sets up all of a board's platform devices and
then their drivers get initialized ... simple
interdependency management; sometimes fancier
models are needed, but Linux does poorly with
those common/fancier requirements, so far
except via techniques some folk retch at.

platform_driver_probe() does
> not work with
> > hotpluged devices.

And was documented that way.  So if anyone
writes code expecting hotplug support, that
person has created a bug.  Their fault.
> =

> That assumption only holds for certain
 devices on certain boards.

It's still classic;  it works very well for
fixed-function SoC boards, no hotpluggable
Platform devices. ... most of the
time they're SoC-integrated, fixed in a
chip.  Sometimes they're just hard-wired
onto a board, (vs hard-wired into a chip).
Such boards are extremely common.

Regardless, if a driver is going to be
hotpluggable, it must be written with
that in mind ... avoiding certain calls, and
addressing various dynamic reconfig issues.

> platform_device_probe() is a machine specific optimization

It's not machine-specific at all, but it may not
be used for those rare platform devices which
are found in hotpluggable configurations.

Even if you want modprobe/rmmod support from
some driver ... that's not a machine issue;
it's a development/support issue. Drivers can
work just fine without being hotpluggable.



> =

> More and more likely all the time though.=A0 Many
> drivers use the model
> of registering child platform_devices (for instance, multi
> function
> devices).

That's *Orthogonal* to hotpluggability..

Something you may be trying to avoid mentioning:
That call can also be a useful way to get driver
initialization sequencing sane, in the ongoing
absence of robust ways for Linux to handle the
interdependencies of drivers and devices.  I'm
told some folk will be working on that someday;
but that day isn't here yet.

- Dave


> =



---------------------------------------------------------------------------=
---
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, an=
d, =

should the need arise, upgrade to a full multi-node Oracle RAC database =

without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
