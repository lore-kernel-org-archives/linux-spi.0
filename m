From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / scan: set status to 0 if _STA failed
Date: Thu, 19 Nov 2015 12:11:49 +0200
Message-ID: <20151119101149.GZ1604@lahna.fi.intel.com>
References: <564D3C75.60208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Bastien Nocera <bugzilla@hadess.net>,
	Stephen Just <stephenjust@gmail.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>, linux-spi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <564D3C75.60208@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 19, 2015 at 11:05:25AM +0800, Aaron Lu wrote:
> Some ACPI node's _STA will touch operation region field, since the
> evaluation of _STA in acpi_bus_type_and_status is very early, the
> operation region handler is not ready yet. Instead of fail that function
> and not creating the acpi_device node consequently, set status to 0 so
> that later when the driver for that device is probing, it can find
> the acpi_device node and proceed normally. And at that time, the
> handler for the operation region is ready and its _STA evaluation will
> succeed, its present status can be checked there.
> 
> Even there will be no driver using this node later, it doesn't seem
> hurt to have one more acpi_device node created with status set to 0.
> 
> This happens on Microsoft Surface 3, where the SPI device node NTRG's
> _STA touches GPIO fields and the SPI core driver will only enumerate SPI
> devices from ACPI if the acpi_device node is 1: created; 2: _STA
> indicates it's present.
> 
> Note that due to another problem in SPI driver, for NTRG to be actually
> enumerated, some changes have to be made in the SPI layer, which is
> addressed by Mika(not send out yet):
> https://bugzilla.kernel.org/show_bug.cgi?id=104291#c23
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=104291
> Reported-by: Bastien Nocera <bugzilla@hadess.net>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

I don't know any better solution to this,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
