From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Add support for slave controllers
	plus sysfs entries for power management
Date: Tue, 16 Feb 2010 15:01:20 -0700
Message-ID: <fa686aa41002161401y72cd08bfq68135e9e259eca2c@mail.gmail.com>
References: <1261170416.10785.5.camel@ubuntu-vmware>
	<fa686aa41001190759j1d916f87o309efe37b3e96bf4@mail.gmail.com>
	<63386a3d1002141520p7cf33256vd8d6f7c23f61b0fe@mail.gmail.com>
	<1b68c6791002141737l6211c88dy79c762a3761cc93c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1b68c6791002141737l6211c88dy79c762a3761cc93c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Feb 14, 2010 at 6:37 PM, jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> On Mon, Feb 15, 2010 at 8:20 AM, Linus Walleij
> <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> 2010/1/19 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>:
>>
>>> =A0The current model is that each spi_device is registered with an
>>> spi_master. =A0Many device drivers operate on the assumption that the
>>> ->master pointer is valid. =A0With this patch, it appears that
>>> spi_devices can be registered either against an spi_master or an
>>> spi_slave; thus invalidating the assumption drivers are already
>>> operating under. =A0That alone makes me nervous.
>>
>> IIRC in my last review of this patch I proposed that drivers be
>> either master, slave or both. With the current approach that would
>> mean putting =A0#ifdefs over the ->master as well and making master
>> support optional. (You can even #ifdef out these parts of the struct
>> to be absolutely sure.)
>
> I don't think adding SPI_SLAVE support is just a matter of providing
> additional callbacks and structures, as is pointed out in this thread....
> http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg00=
368.html
>
> We'd better see if the implementation covers at least some aspects of
> being a SPI slave,
> otherwise it seems more like a 'workaround' than support.

I agree.  I need to see a real usage model before I merge anything.
As it stands right now, spi_master looks like an entirely different
thing from an spi_slave, even if both happen to use spi_messages
(although spi_message only seems to handle a small number of the
possible spi slave use cases.  For example, it doesn't address at all
a command and response within the same SPI transfer).  I don't at all
like the idea of allowing the current spi_device to be registered on
either an spi_master or an spi_slave.

I may let a driver through that happens to turn on an SPI slave mode
in the hardware, but if you're doing that, be aware that it may be an
abuse of the spi_master model, and you'll get little sympathy when
breakage happens.

I haven't seen anything spi_slave related yet that I'll merge in the
common spi code.

g.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
