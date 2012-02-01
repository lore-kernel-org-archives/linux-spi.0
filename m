From: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus number
	via dts
Date: Wed, 1 Feb 2012 15:53:00 +0100
Message-ID: <CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg@mail.gmail.com>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
	<20120201135524.GD13723@sirena.org.uk>
	<CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
	<20120201140838.GE13723@sirena.org.uk>
	<CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
	<20120201143558.GF13723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120201143558.GF13723-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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
> > Good question. I have a nvSRAM that I access using the AT25 driver, and I
> > don't know how access it without its /sys/bus/ name. If there is another
> > way, it is worse to consider it.
>
> For this I'd expect the application to be able to enumerate all the SPI
> devices and offer the user a selection of those with the appropriate
> driver bound (though I can see that simple scripts might not have
> bothered).
>

???
I wrote a piece of code that uses this nvSRAM as a persistent storage.
This runs in a softcore embedded in an FPGA, in an equipment.
The PC version of this application uses a simple file to emulate this
behavior.
The simulated version, using an x86 port embedded in a VirtualBox uses a
piece of virtual disk with /dev/sdb.

To sumarize, I have a same code that works for the 3 architecture, the
single difference being in the device name:
/sys/proc/spi/drivers/at25/spi0.0/eeprom for Nios2
dataBase.dat on Linux
/dev/sdb on the Virtual Machine

Why should I have to break that, which work nice, to use a bus enumeration
which would be specific to the real hardware version, because I'm using a
new tools, DTS, which is supposed to simplify my life.
Sorry to insist, but this incapacity to set the bus number is a *real*
regression (for me).

I know I could use the name chosen by the kernel (it mus be something like
/sys/.../spi253.0/...), but I have no control on it. If tomorrow someone
changes something in the spi bus number definition, a kernel upgrade will
have an impact on the user stuff...
------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
