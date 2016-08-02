From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v2 2/2] spi: octeon: Add thunderx driver
Date: Tue, 2 Aug 2016 14:49:41 -0700
Message-ID: <57A11575.2070000@caviumnetworks.com>
References: <20160728083144.16625-1-jglauber@cavium.com> <20160728083144.16625-3-jglauber@cavium.com> <20160801172838.GW10376@sirena.org.uk> <579F958F.9020508@caviumnetworks.com> <20160801184931.GB10376@sirena.org.uk> <579F9CDE.5050207@caviumnetworks.com> <20160802213018.GL10376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Glauber <jglauber@cavium.com>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, David Daney <david.daney@cavium.com>,
	"Steven J . Hill" <steven.hill@cavium.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160802213018.GL10376@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/02/2016 02:30 PM, Mark Brown wrote:
> On Mon, Aug 01, 2016 at 12:02:54PM -0700, David Daney wrote:
>> On 08/01/2016 11:49 AM, Mark Brown wrote:
>
>>> What is that thing on ACPI systems?
>
>> I don't know if it works ACPI, or if ACPI even has support for the clock
>> framework.  But does it matter?  We are not currently using ACPI on systems
>> where this driver is used.
>
>> In the future, if we ever need ACPI support, we will add support for it.
>
> Oh, that's surprising - I thought these were server systems.

There are two broad classes of systems targeted by Cavium's arm64 based 
SoCs:

1) 2-node NUMA servers with 96 CPUs running UEFI firmware and ACPI.  For 
these, any SPI buses are managed by the firmware and we don't need 
Kernel support.

2) Embedded controllers with 4 - 32 CPUs, typically running u-boot and 
OF device tree firmware descriptions.  For these configurations, SPI 
buses managed by the kernel must be supported.


> With ACPI
> you need to use DMI data or something to instantiate the clock.  In any
> case if you've got it working that should be OK.
>
