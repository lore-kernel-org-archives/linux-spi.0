From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI
	enumerated I2C slaves
Date: Fri, 25 Oct 2013 16:30:23 +0300
Message-ID: <526A726F.1030407@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <6032482.JJ4PNSSnIp@vostro.rjw.lan> <526A6A41.6020909@linux.intel.com>
 <98785510.yWYAtabkbj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>,
 linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <98785510.yWYAtabkbj@vostro.rjw.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On 10/25/2013 04:18 PM, Rafael J. Wysocki wrote:
> On Friday, October 25, 2013 03:55:29 PM Jarkko Nikula wrote:
>>
>> Well, acpi_bus_get_device() is not available for non-ACPI builds and at
>> least the gcc I used for test build didn't optimize that block away.
> Well, it should.  ACPI_HANDLE() translates to (NULL) if CONFIG_ACPI
> is not defined and that causes the check to become "if (NULL)" which
> should always be dropped by the compiler.
>
My very vague memory says the same. I don't know is this gcc version or 
flag dependent behavior. I got the build error from both i386 build 
using gcc 4.8.1 and arm build by using make ARCH=arm omap2plus_defconfig 
and gcc-4.7-arm-linux-gnueabi 4.7.2-4.
> Does providing a stub acpi_bus_get_device() for !CONFIG_ACPI actually help?
>
>
Hmm, not only. Referencing to dev field in struct acpi_device by 
dev_name(&adev->dev) here will fail too.

-- 
Jarkko
