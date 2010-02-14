From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add support for slave controllers
	plus sysfs entries for power management
Date: Mon, 15 Feb 2010 00:20:19 +0100
Message-ID: <63386a3d1002141520p7cf33256vd8d6f7c23f61b0fe@mail.gmail.com>
References: <1261170416.10785.5.camel@ubuntu-vmware>
	<fa686aa41001190759j1d916f87o309efe37b3e96bf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41001190759j1d916f87o309efe37b3e96bf4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/1/19 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>:

> =A0The current model is that each spi_device is registered with an
> spi_master. =A0Many device drivers operate on the assumption that the
> ->master pointer is valid. =A0With this patch, it appears that
> spi_devices can be registered either against an spi_master or an
> spi_slave; thus invalidating the assumption drivers are already
> operating under. =A0That alone makes me nervous.

IIRC in my last review of this patch I proposed that drivers be
either master, slave or both. With the current approach that would
mean putting  #ifdefs over the ->master as well and making master
support optional. (You can even #ifdef out these parts of the struct
to be absolutely sure.)

The AMBA PL022 can act as both master or slave for example.
It is possible to support either, master, slave, or both modes on this.

You won't act as both master and slave on a certain bus. So at
probetime a dual-mode thing like a PL022 would have to
decide for being either master or slave. But it's not possible to
do so at compile time: we may have a plethora of PL022:s on
a SoC, some masters, some slaves.

If spraying #ifdefs all over the place is undesirable, spi.h need
to be split in spi-master.h and spi-slave.h IMHO, but they may
share so much code and structure that #ifdefs is less disturbing
really.

> Do you expect any spi_device to be registered on an spi_slave?
>=A0Does the behaviour of an spi_device need
> to change when it is registered against an spi_slave?

Not that I'm an expert on how people construct their SPI systems,
but only masters have devices, right? If you're a slave, some
other master is asking you for something, so if one used USB
terminology (why not) slaves would have functions, not devices,
and function drivers, not device drivers.

Just my =800.01...

Linus Walleij

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
