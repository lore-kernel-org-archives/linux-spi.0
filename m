From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] of: add bus-number specification to spi_mpc8xxx
Date: Tue, 16 Feb 2010 14:23:49 -0700
Message-ID: <fa686aa41002161323v72dbcdb4rd28ece040c878972@mail.gmail.com>
References: <20100216150850.d966cd79.eschwab@online.de>
	<fa686aa41002160628g62bd6564h50e712e8fb9c384d@mail.gmail.com>
	<20100216160832.730cb00b.eschwab@online.de>
	<fa686aa41002160718u36fe6f7ey7be83ab69317ec76@mail.gmail.com>
	<20100216195943.e40e104e.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100216195943.e40e104e.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
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

On Tue, Feb 16, 2010 at 11:59 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>
>> Add a property to the /chosen node to assign short labels to devices.
>
> I'm not familiar with this and will check - does anyone know of an
> existing example for this?

Oops, sorry.  I meant the 'aliases' node.  'chosen' is for something else.

Properties in the aliases node are simply name =3D "/path/to/node";
pairs.  Do "grep -A 6 arch/powerpc/boot/dts/" to see lots of examples.
dtc expands the <name> =3D &label; construct into the full path to the
node.

>> Unless you're trying to line up disparate data structure, the actually
>> number assigned to a bus really doesn't matter. =A0It is better to let
>> Linux dynamically assign than to manually maintain the assigned bus
>> numbers for each machine. =A0Assuming dynamic assignment also protects
>> against breaking userspace applications when, for whatever reason, the
>> bus numbers get shuffled on a platform.
>
> Hm. What if we have two identical devices, lets say EEPROMs at25,
> connected to two SPI controllers. These are set up as
> /sys/bus/spi/devices/spi32766.0/eeprom and
> /sys/bus/spi/devices/spi32765.0/eeprom.
> How can userspace code determine which one it should
> use if it needs to use the one connected to the first spi controller?
> Can this be solved with the /chosen mechanism?

Use the alias to find the spi bus you care about in /sys/devices/.
Then whichever eeprom has that bus as its parent is the device you
want.  You can read the expanded device tree in /proc/device-tree.
Unfortunately I don't have sample code that shows how to do this; I
haven't had to do so personally yet.

g.
