From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: bitbang & mpc83xx setup_transfer()
Date: Fri, 7 Mar 2008 18:09:00 -0800
Message-ID: <200803071809.00453.david-b@pacbell.net>
References: <1204908064.29669.44.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1204908064.29669.44.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 07 March 2008, Joakim Tjernlund wrote:
> I am a bit confused where one should do spi HW setup.

Depends which parts of setup you mean.

For controllers that have per-slave registers, the normal approach
is to arrange that spi_setup() initialize those registers.  That way
the chipselect() effectively just specifies which slave slave register
bank to use, and toggles a GPIO.  Then setup_transfer() will at most
need to change wordsize and speed.

For controllers that have global registers not pre-slave ones, think
of the requirement as preserving the illusion that there are per-slave
registers.  So the chipselect code will need to write the correct
values for CPOL, CPHA, endianness, and so on, as well as the stuff that
setup_transfer() does.


> Currently both 
> mpc83xx_spi_setup_transfer() and mpc83xx_spi_chipselect() touches the
> HW controller. I suspect that this is so because
> mpc83xx_spi_setup_transfer() only gets called if one supply speed or
> word size thereby forcing mpc83xx_spi_chipselect() do it too and I doubt
> the speed and wordsize is correctly dealt with in
> mpc83xx_spi_chipselect().

I'd suspect that there should be one chunk of code setting up wordsize
and clock rate, in setup_transfer(), and it should be called from the
chipselect code (as well as the transfer loop).

 
> The current situation for mpc83xx is suboptimal and can cause gliches on
> CLK as one must disable the controller before any change is to be
> performed and then reenabled it. The SPI I/O pins is floating while
> the controller is disabled.

Sounds right.  But unless you prevent the acceptance of inline protocol
tweaking options (adjacent transfers using different word sizes and/or
bitrates, in the same message) you've got to work around that glitch
by ensuring that the clock signal stays inactive (and probably that MOSI
doesn't float) while transfer characterstics are reconfigured.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
