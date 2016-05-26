From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Thu, 26 May 2016 03:56:11 +0200
Message-ID: <574657BB.6070300@weinigel.se>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk> <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk> <5744E51A.1040506@gmail.com>
 <20160525174932.GA10753@rob-hp-laptop> <5745E9B6.5090204@gmail.com>
 <20160525184442.GE8206@sirena.org.uk> <57464D0A.1030706@weinigel.se>
 <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJwQvPGtscheZjoJyhF1UPxDSqbS-QB9qm3M4HbpOicVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/26/2016 03:44 AM, Rob Herring wrote:
> Lovely. "Here's something that's simple and useful for users. Let's 
> break it". What part of "we do not break userspace" do you not 
> understand? Because that would be a user visible change.
> The other saying is "if it is not upstream, it doesn't exist." That
> said, I don't think we should remove it. Maybe some time later, but
> first we need a suitable alternative.
Huh?  Commit bb29785e0d6d, which added support for assigning spi bus 
numbers via devicetree aliases, has been in the upstream Linux kernel 
since v3.9 which was released over three years ago.

   /Christer

-- 
Have laptop, will travel.  I'm a consultant looking for interesting
jobs anywhere in the world.  I'm an experienced software engineer with
a solid understanding of hardware.  Specialities: Linux, device
drivers and embedded systems in general.  Find me at www.weinigel.se.
