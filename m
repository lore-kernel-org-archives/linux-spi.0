From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 1/4] [POWERPC][SPI]
	spi_mpc83xx.c:	should turn off SPI unit while switching any mode.
Date: Fri, 27 Jul 2007 17:36:28 +0400
Message-ID: <20070727133628.GA19151@localhost.localdomain>
References: <20070726131134.GA3309@localhost.localdomain>
	<20070726131346.GA3417@localhost.localdomain>
	<250FD11F-9ADC-46CC-B652-1148FC549316@kernel.crashing.org>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <250FD11F-9ADC-46CC-B652-1148FC549316-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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

On Fri, Jul 27, 2007 at 01:32:27AM -0500, Kumar Gala wrote:
>
> On Jul 26, 2007, at 8:13 AM, Anton Vorontsov wrote:
>
>> Documentation clearly states, that mode should not be changed
>> till SPMODE_ENABLE bit set. I've seen hangs w/o this patch.
>
> Out of interest what board/part do you see the hang on?

It's MPC8323E-RDB.

Using spidev_test utility:

root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# ./a.out -D /dev/spidev1.0
spi mode: 0
bits per word: 8
max speed: Hz (kHz): 500000 (500)
...
root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~#


Then trying change bits per word to 32:

root-/FxswC0nw/VuxbqukCiDuA@public.gmane.org:~# ./a.out -D /dev/spidev1.0 -b 32
spi mode: 0
bits per word: 32
max speed: Hz (kHz): 500000 (500)
<---- hang

Board is still alive, but SPI isn't.

Though, there are various steps to reproduce the same.
So SPI unit should be really turned off to change mode.

Thanks,

-- 
Anton Vorontsov
email: cbou-JGs/UdohzUI@public.gmane.org
backup email: ya-cbou-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
