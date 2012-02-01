From: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus number
	via dts
Date: Wed, 1 Feb 2012 16:29:25 +0100
Message-ID: <CAMVnO+kvjbxW7EdMe_YF=oSp0bR-RqaP_rPM57tyHzGKhsoNxg@mail.gmail.com>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
	<20120201135524.GD13723@sirena.org.uk>
	<CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
	<20120201140838.GE13723@sirena.org.uk>
	<CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
	<20120201143558.GF13723@sirena.org.uk>
	<CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg@mail.gmail.com>
	<20120201150517.GG13723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120201150517.GG13723-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>
> > I wrote a piece of code that uses this nvSRAM as a persistent storage.
> > This runs in a softcore embedded in an FPGA, in an equipment.
> > The PC version of this application uses a simple file to emulate this
> > behavior.
> > The simulated version, using an x86 port embedded in a VirtualBox uses a
> > piece of virtual disk with /dev/sdb.
>
> So it's just a basic block device?
>

It is the purpose of AT25, yes.


>  > To sumarize, I have a same code that works for the 3 architecture, the
> > single difference being in the device name:
> > /sys/proc/spi/drivers/at25/spi0.0/eeprom for Nios2
> > dataBase.dat on Linux
> > /dev/sdb on the Virtual Machine
>
> In this case surely the mechanisms used to identify regular disks (UUIDs
> and so on) will also work (the .dat file will have to be an override,
> but otherwise...)?  Names like sdb aren't stable either - they can
> change with either software or hardware changes since they just come
> from the order of discovery.
>

Sure there are mechanisms, but that means that the code must be either
specific to the arch, either have the code for all of them. Not simple !

The other issue with your patch is that setting a bus number is
> obviously not a device specific thing, it's something that will apply to
> any SPI controller on Linux, and so shouldn't be something driver
> specific but should instead be a change to the SPI core.
>

Although I tend to agree you on the fact that SPI bus num is a SPI core
matter, but the fact is that, for now, it is the controller that must fill
the spi_master structure to call spi_master_get(), and that this structure
contains a field 'bus_num' that is always initialized to -1 since DTS...

-- 
Fred
------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
