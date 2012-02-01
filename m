From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus
 number via dts
Date: Wed, 1 Feb 2012 15:05:17 +0000
Message-ID: <20120201150517.GG13723@sirena.org.uk>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
 <20120201135524.GD13723@sirena.org.uk>
 <CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
 <20120201140838.GE13723@sirena.org.uk>
 <CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
 <20120201143558.GF13723@sirena.org.uk>
 <CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 01, 2012 at 03:53:00PM +0100, Frederic LAMBERT wrote:

> I wrote a piece of code that uses this nvSRAM as a persistent storage.
> This runs in a softcore embedded in an FPGA, in an equipment.
> The PC version of this application uses a simple file to emulate this
> behavior.
> The simulated version, using an x86 port embedded in a VirtualBox uses a
> piece of virtual disk with /dev/sdb.

So it's just a basic block device?

> To sumarize, I have a same code that works for the 3 architecture, the
> single difference being in the device name:
> /sys/proc/spi/drivers/at25/spi0.0/eeprom for Nios2
> dataBase.dat on Linux
> /dev/sdb on the Virtual Machine

In this case surely the mechanisms used to identify regular disks (UUIDs
and so on) will also work (the .dat file will have to be an override,
but otherwise...)?  Names like sdb aren't stable either - they can
change with either software or hardware changes since they just come
from the order of discovery.

> Why should I have to break that, which work nice, to use a bus enumeration
> which would be specific to the real hardware version, because I'm using a
> new tools, DTS, which is supposed to simplify my life.
> Sorry to insist, but this incapacity to set the bus number is a *real*
> regression (for me).

> I know I could use the name chosen by the kernel (it mus be something like
> /sys/.../spi253.0/...), but I have no control on it. If tomorrow someone
> changes something in the spi bus number definition, a kernel upgrade will
> have an impact on the user stuff...

We went through exactly the same routine whenever people noticed that
the names for disks weren't as stable as people had been assuming, for
example with the SATA transition from IDE to SCSI, with network devices,
and in a few other places too.  Coming up with fixed names for things
that don't depend on implementation details is really rather hard and
tends to break down eventually either due to software changes or due to
newer hardware.

The other issue with your patch is that setting a bus number is
obviously not a device specific thing, it's something that will apply to
any SPI controller on Linux, and so shouldn't be something driver
specific but should instead be a change to the SPI core.
