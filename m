From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] eeprom/of: Add device tree bindings to at25.
Date: Tue, 15 May 2012 08:47:17 -0700
Message-ID: <20120515154717.GA15552@kroah.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Axel Lin <axel.lin@gmail.com>
To: David Daney <ddaney.cavm@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 11, 2012 at 03:05:23PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> We can extract the "pagesize", "size" and "address-width" from the
> device tree so that SPI eeproms can be fully specified in the device
> tree.
> 
> Also add a MODULE_DEVICE_TABLE so the drivers can be automatically bound.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Axel Lin <axel.lin@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

