From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Fri, 17 Jan 2014 09:37:56 +0200
Message-ID: <52D8DDD4.10704@linux.intel.com>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com> <1389689198-2641-4-git-send-email-rui.zhang@intel.com> <20140116122704.GD2617@katana> <1389877509.3010.15.camel@rzhang1-mobl4> <20140116194651.GO17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Zhang Rui <rui.zhang@intel.com>, Wolfram Sang <wsa@the-dreams.de>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
	gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	grant.likely@linaro.org, mika.westerberg@linux.intel.com,
	grant.likely@secretlab.ca
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140116194651.GO17314@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/16/2014 09:46 PM, Mark Brown wrote:
> On Thu, Jan 16, 2014 at 09:05:09PM +0800, Zhang Rui wrote:
>> On Thu, 2014-01-16 at 13:27 +0100, Wolfram Sang wrote:
>> This seems a gap to me but I'm not 100% sure.
>> I saw Grant Likely introduced the OF style MODALIAS to platform bus, and
>> OF style registration/binding to i2c bus, maybe he has an answer for
>> this.
> This is needed for ACPI because we rewrite the device names to give us
> stable names.  With OF for I2C and SPI nothing bus specific is done that
> affects this stuff so the default behaviour works.
Sidenote: actually this modalias/module loading issue is different and 
not related to stable ACPI i2c/spi slave device names.

-- 
Jarkko
