From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 0/3] I2C and SPI dev_name change for ACPI enumerated slaves
Date: Fri, 01 Nov 2013 23:58:45 +0100
Message-ID: <3989164.GAoLSa6qzM@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <20131101132048.GD6734@katana> <5273B046.1030204@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5273B046.1030204@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, November 01, 2013 03:44:38 PM Jarkko Nikula wrote:
> On 11/01/2013 03:20 PM, Wolfram Sang wrote:
> > On Fri, Nov 01, 2013 at 02:18:06PM +0100, Rafael J. Wysocki wrote:
> >>
> >> Looks good to me.  If there are no objections, I can merge these through my tree.
> > Which is basically fine with me. Do you want to have it in 3.13 already?
> > I mean renaming the devices could lead to regressions, so I'd rather be
> > conservative and aim for 3.14.
> >
> Valid concern. Quick grep below doesn't reveal any obvious device name 
> matching outside of sound/soc/ but of course it doesn't prove it to be 
> impossible.
> 
> git grep '[0-9]\-00' |grep name
> git grep 'spi[0-9].[0-9]' |grep name

Well, if any breakage is caught in 3.13-rc, it should be easy enough to revert
these changes and try again during the next cycle.  I honestly don't see any
benefit from waiting for the next cycle "just in case".

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
