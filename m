From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus
 number via dts
Date: Wed, 1 Feb 2012 15:42:04 +0000
Message-ID: <20120201154204.GH13723@sirena.org.uk>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
 <20120201135524.GD13723@sirena.org.uk>
 <CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
 <20120201140838.GE13723@sirena.org.uk>
 <CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
 <20120201143558.GF13723@sirena.org.uk>
 <CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg@mail.gmail.com>
 <20120201150517.GG13723@sirena.org.uk>
 <CAMVnO+kvjbxW7EdMe_YF=oSp0bR-RqaP_rPM57tyHzGKhsoNxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMVnO+kvjbxW7EdMe_YF=oSp0bR-RqaP_rPM57tyHzGKhsoNxg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, Feb 01, 2012 at 04:29:25PM +0100, Frederic LAMBERT wrote:

> >  > To sumarize, I have a same code that works for the 3 architecture, the
> > > single difference being in the device name:
> > > /sys/proc/spi/drivers/at25/spi0.0/eeprom for Nios2
> > > dataBase.dat on Linux
> > > /dev/sdb on the Virtual Machine

> > In this case surely the mechanisms used to identify regular disks (UUIDs
> > and so on) will also work (the .dat file will have to be an override,
> > but otherwise...)?  Names like sdb aren't stable either - they can
> > change with either software or hardware changes since they just come
> > from the order of discovery.

> Sure there are mechanisms, but that means that the code must be either
> specific to the arch, either have the code for all of them. Not simple !

Well, something that walks all block devices on Linux is very
straightforward...  It sounds like you just want logic along the lines
of "find a block device and offer the option of overriding by providing
a specific path for use with a file", is that about right?

> The other issue with your patch is that setting a bus number is
> > obviously not a device specific thing, it's something that will apply to
> > any SPI controller on Linux, and so shouldn't be something driver
> > specific but should instead be a change to the SPI core.

> Although I tend to agree you on the fact that SPI bus num is a SPI core
> matter, but the fact is that, for now, it is the controller that must fill
> the spi_master structure to call spi_master_get(), and that this structure
> contains a field 'bus_num' that is always initialized to -1 since DTS...

This sounds like a simple matter of proramming to change.  Clearly
providing a standard feature of the SPI subsystem will involve
modification of the SPI core, for example to change the interpretation
of -1 to go look at the device tree and override it.
