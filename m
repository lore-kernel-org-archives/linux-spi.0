From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/9 v3] staging: spi: mt7621: Switch to SPDX identifier
Date: Tue, 5 Feb 2019 07:29:36 +0100
Message-ID: <46229a39-b337-6180-b745-5bcf32dbc155@denx.de>
References: <20190201101715.3760-1-sr@denx.de>
 <20190201130355.GG20797@sirena.org.uk>
 <87muncjyb3.fsf@notabene.neil.brown.name>
 <20190204085302.GB23441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-spi@vger.kernel.org, Sankalp Negi <sankalpnegi2310@gmail.com>,
 John Crispin <john@phrozen.org>
To: Mark Brown <broonie@kernel.org>, NeilBrown <neil@brown.name>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190204085302.GB23441@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

On 04.02.19 09:53, Mark Brown wrote:
> On Mon, Feb 04, 2019 at 09:34:56AM +1100, NeilBrown wrote:
> 
>>   It is extremely common in the kernel for a file to start
>>     // SPDX-License-Identifier.....
> 
>>   and to have that immediately followed by a comment lile:
> 
>>   /*
>>    * .....
>>    * ....
> 
> Yes, there was a lot of automated conversion AFAICT (and a lot of
> confusion with all this stuff only being documented in random mailing
> list posts for a long time).
> 
>>   This patch makes this file match much of the rest of the kernel.  Why
>>   do you want something different?
> 
> Like I said because it makes the comments look more like someone
> actually meant to add a C++ comment - it's what the rest of the
> subsystem is doing too.

If nobody objects, I will do this change to C++ comments in the header
with the move out of staging into drivers/spi.

Thanks,
Stefan
