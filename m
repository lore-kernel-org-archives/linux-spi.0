From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: PATCH [0/1] SPI: AMBA_PL022: Limit TX FIFO
 fills based on current RX FIFO used
Date: Wed, 20 Jan 2010 19:37:51 +0100
Message-ID: <083DF309106F364B939360100EC290F805C4BF1E96@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


This patch works around an issue where transfers larger than the
FIFO depth can generate RX FIFO overflows when in interrupt and
polling modes by counting the number of empty RX FIFO locations.

When populating the TX FIFO with data, an entry in the TX FIFO
will go to a serial data shifter if it's empty. This allows the
TX FIFO to initially be filled with up to 9 entries if the TX
FIFO an serial data shifter are both empty empty before the TX
FIFO full flag is set. For high SPI clock rates and the selected
FIFO trip point, its possible that the RX FIFO may not get
serviced fast enough to prevent more than 8 RX FIFO entries from
occuring causing an RX overflow.

This has been tested with full deplex 4K block transfer @8-bits
using a 8 entry deep FIFO PL022 and a 256Mbit serial EEPROM.

The excerpt about the serial shifter from the pl022 TRM is below.

*snip*
When SSPDR is written to, the entry in the transmit FIFO (pointed to by the write
pointer), is written to. Data values are removed from the transmit FIFO one value at a
time by the transmit logic. It is loaded into the transmit serial shifter, then serially
shifted out onto the SSPTXD pin at the programmed bit rate.
*snip*

thanks,
Kevin Wells
NXP Semiconductors

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
