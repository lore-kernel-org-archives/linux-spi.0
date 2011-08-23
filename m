From: Roman Lapin <lampus.lapin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Question about Chip Select Decoding for AT91
Date: Tue, 23 Aug 2011 12:30:00 +0400
Message-ID: <CACsCNcmdbcy-TO8SuO4PXT+gvLPyZyj-11hn+ZfkqMFhYkW0Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello. I am newbie in kernel development.
I want to realize chip select decoding function for AT91. And I'm finding
the simplest method for it.
I have some questions:
1. Why sizes of variables u8 spi_device.mode, u16 spi_master.mode_bits and
u32 bad_bits in spi_setup() are different?
I've wanted to use variable spi_device.mode for saving cs_dec flag, but I
couldn't do it, because spi_device.mode is fully used for other flags.
2. I want to use spi_device.controller_data to pass pointer to GPIO array
used for CS pins. If cs_dec flag is set, so I can interpret pointer in
spi_device.controller_data
as pointer to array of CS pins GPIO, in either case it will be interpreted
as one CS pin GPIO. Is it right way?
Sorry for my bad english.
------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
