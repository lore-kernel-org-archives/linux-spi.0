From: Frederic LAMBERT <frdrc66-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/spi-altera: Allow to explicitely override bus number
	via dts
Date: Wed, 1 Feb 2012 16:52:14 +0100
Message-ID: <CAMVnO+nB77XOQHfL1zZLve_=z6vFk_HMF+hj=iMTAuOAYSRExA@mail.gmail.com>
References: <1328025246-23450-1-git-send-email-tklauser@distanz.ch>
	<20120201135524.GD13723@sirena.org.uk>
	<CAMVnO+kWX=NYi+YU9H5nRc9UksCJLQUi-_Kj9UASwoiqZj9tGA@mail.gmail.com>
	<20120201140838.GE13723@sirena.org.uk>
	<CAMVnO+m5DTYeK9mHcciqU-y7HGP-d9FXWkvTV4ZJJLTRqjK7LQ@mail.gmail.com>
	<20120201143558.GF13723@sirena.org.uk>
	<CAMVnO+n2SW=e7EP-MjLbFeF7ZW6e=FwL=UdOd=cd-XN=C132Qg@mail.gmail.com>
	<20120201150517.GG13723@sirena.org.uk>
	<CAMVnO+kvjbxW7EdMe_YF=oSp0bR-RqaP_rPM57tyHzGKhsoNxg@mail.gmail.com>
	<20120201154204.GH13723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120201154204.GH13723-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2012/2/1 Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>

>
> Well, something that walks all block devices on Linux is very
> straightforward...  It sounds like you just want logic along the lines
> of "find a block device and offer the option of overriding by providing
> a specific path for use with a file", is that about right?
>

Well, yes, excepted that the file *is* equivalent to a block device for my
piece of code!

 > Although I tend to agree you on the fact that SPI bus num is a SPI core
> > matter, but the fact is that, for now, it is the controller that must
> fill
> > the spi_master structure to call spi_master_get(), and that this
> structure
> > contains a field 'bus_num' that is always initialized to -1 since DTS...
>
> This sounds like a simple matter of proramming to change.  Clearly
> providing a standard feature of the SPI subsystem will involve
> modification of the SPI core, for example to change the interpretation
> of -1 to go look at the device tree and override it.
>

Yes, that seems simple said like that.
It was thus more simple for me, at that time, to modify a specific driver
for a specific port (Nios2), than to modify a core used by every one.
Question of time, and confidence in my own capacities :-).
The other point being the change acceptation (and the time it takes) by the
community...

-- 
Fred
------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
