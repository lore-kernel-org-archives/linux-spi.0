From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH v9] spi: New driver for Altera SPI
Date: Mon, 14 Feb 2011 15:20:46 +1300
Message-ID: <4D58917E.9050408@bluewatersys.com>
References: <1297142509-20158-1-git-send-email-thomas@wytron.com.tw> <1297649443-11491-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net
To: Thomas Chou <thomas@wytron.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1297649443-11491-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/14/2011 03:10 PM, Thomas Chou wrote:
> This patch adds a new SPI driver to support the Altera SOPC Builder
> SPI component. It uses the bitbanging library.
> 
> Signed-off-by: Thomas Chou <thomas@wytron.com.tw>
> ---

> +struct altera_spi {
> +	/* bitbang has to be first */
> +	struct spi_bitbang bitbang;

Is this still true? I had a quick look and can't see anything which
relies on spi_bitbang being the first entry. Things like this should be
using container_of so that position in the struct is irrelevant.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
