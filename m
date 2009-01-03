From: "Colin McCabe" <colin-W/OLz77bvjtBDgjK7y7TUQ@public.gmane.org>
Subject: new spi_device features
Date: Fri, 2 Jan 2009 19:28:49 -0800
Message-ID: <314b98fa0901021928j1cdcb4d7le44950beca2d3fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>,
	Andrey Yurovsky <andrey-W/OLz77bvjtBDgjK7y7TUQ@public.gmane.org>,
	Peter Wippich <pewi-B3s+bhPyRsEtqAddL8MvRLNAH6kLmebB@public.gmane.org>, Harald Welte <laforge-TgoAw6mPHtdg9hUCZPvPmw@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi all.

I've been using the generic SPI support in include/linux/spi/spi.h and
for the most part it is just what the doctor ordered.
However, there are a few features I'd like to see included in the
generic SPI framework that aren't there now.

I would like to see support for a "GPIO-style chipselect"-- i.e., a
chipselect that stays active for the entire transaction, rather than
being dropped after each individual word in the transaction. I would
also like to be able to add busy-waits into the transaction. (I cannot
simply use 2 different transactions, because the busy wait must take
place with chip select asserted.)

A few SPI controller drivers seem to already implement GPIO-style chip
selects. But they must be configured using board-specific options.
And, of course, busy-waits can be implemented in the core without SPI
controller support.

There is a comment in spi.h that says that we "likely need more hooks
for more protocol options affecting how the controller talks to each
chip," and goes on to mention these two features, among others. Does
anyone have a patch that adds support for these features?
If not, I would like to create one. In that case, what git repository
should I base my patches against?

sincerely,
Colin

------------------------------------------------------------------------------
