From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Thu, 26 May 2016 03:10:34 +0200
Message-ID: <57464D0A.1030706@weinigel.se>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk> <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk> <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop> <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525184442.GE8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/25/2016 08:44 PM, Mark Brown wrote:
> On Wed, May 25, 2016 at 11:06:46AM -0700, Frank Rowand wrote:
>> On 5/25/2016 10:49 AM, Rob Herring wrote:
> 
>>> Things get undocumented all the time when we deprecate them.
> 
>> If it is deprecated then it should be documented as deprecated
>> so people do not attempt to use it.
> 
> Or we could just remove the code, we don't appear to have any in
> tree users anyway (the few in tree aliases for SPI buses I can see
> are string based).

Lovely.  "Here's something that's simple and useful for users.  Let's
break it".  What part of "we do not break userspace" do you not
understand?  Because that would be a user visible change.

  /Christer
