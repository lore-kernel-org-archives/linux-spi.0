From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] of: add bus-number specification to spi_mpc8xxx
Date: Wed, 17 Feb 2010 12:11:05 +0100
Message-ID: <20100217121105.89ec9fa8.eschwab@online.de>
References: <20100216150850.d966cd79.eschwab@online.de>
	<fa686aa41002160628g62bd6564h50e712e8fb9c384d@mail.gmail.com>
	<20100216160832.730cb00b.eschwab@online.de>
	<fa686aa41002160718u36fe6f7ey7be83ab69317ec76@mail.gmail.com>
	<20100216195943.e40e104e.eschwab@online.de>
	<fa686aa41002161323v72dbcdb4rd28ece040c878972@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <fa686aa41002161323v72dbcdb4rd28ece040c878972-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 16 Feb 2010 14:23:49 -0700
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Tue, Feb 16, 2010 at 11:59 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> > Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> >
> >> Add a property to the /chosen node to assign short labels to devices.
> >
> > I'm not familiar with this and will check - does anyone know of an
> > existing example for this?
> 
> Oops, sorry.  I meant the 'aliases' node.  'chosen' is for something else.
> 
> Properties in the aliases node are simply name = "/path/to/node";
> pairs.  Do "grep -A 6 arch/powerpc/boot/dts/" to see lots of examples.
> dtc expands the <name> = &label; construct into the full path to the
> node.

Ok, as I did the grep with "chosen" there wasn't anything, "aliases" 
looks much better. I was aware of this node, but had no idea how
to use it. Actually, I still do not exactly know how to use it ;-).

> Use the alias to find the spi bus you care about in /sys/devices/.
> Then whichever eeprom has that bus as its parent is the device you
> want.  You can read the expanded device tree in /proc/device-tree.
> Unfortunately I don't have sample code that shows how to do this; I
> haven't had to do so personally yet.

I created 
	aliases { ...
		spi0 = &spi;
		eepmain   = &eepmain;
	};

	spi:spi@7000 { ...
		eepmain:eeprom@8 { ...
		};
	};

The aliases are visible at /proc/device-tree/aliases/:
eepmain   : contains /immr@e0000000/spi@7000/eeprom@8
spi0      : contains /immr@e0000000/spi@7000

The EEPROM can be accessed under 
	/sys/bus/spi/devices/spi32766.8/eeprom

The alias names do not appear in /sys as far as I can see.
The paths (e.g. /immr@e0000000/spi@7000) seems not to be useable
to address something in the /sys directory directly.

Does this mean that software which wants to access 'eepmain' 
has to reformat the alias value to construct a path in the sysfs
to access the EEPROM contents?

Regards
Ernst
