From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv4 0/3] I2C and SPI dev_name change for ACPI enumerated slaves
Date: Sat, 16 Nov 2013 02:30:02 +0100
Message-ID: <1555543.PnMRFYHnJ2@vostro.rjw.lan>
References: <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com> <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, November 14, 2013 02:03:50 PM Jarkko Nikula wrote:
> v4:
> This version adds and uses acpi_dev_name() accessor instead defining
> struct acpi_device stub for !CONFIG_ACPI 
> 
> v3:
> Third version of the set that changes I2C and SPI slave device names
> to be generated from stable ACPI device names on ACPI 5 based systems
> instead of using bus numbers which could change.
> 
> Slave device name change goes as
> 
> 	"x-00yz" -> "i2c-INTABCD:ij"
> 	"spix.y" -> "spi-INTABCD:ij"
> 
> This version is actually a bit cleaner thanks to Rafael's
> "ACPI / driver core: Store an ACPI device pointer in struct acpi_dev_node"
> in git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> 
> Set goes on top of linux-pm/linux-next due dependency to 1/3. As we are now
> in merge-window I'm fine if 1/3 goes in first and I queue 2-3/3 later
> to i2c and spi trees.
> 
> Jarkko Nikula (3):
>   ACPI: Provide acpi_dev_name accessor for struct acpi_device device
>     name
>   i2c: Use stable dev_name for ACPI enumerated I2C slaves
>   spi: Use stable dev_name for ACPI enumerated SPI slaves

All three queued up for the next ACPI pull request, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
