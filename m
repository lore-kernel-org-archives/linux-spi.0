From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH v3 1/1] spi: Using Trigger number to transmit/receive
 data
Date: Tue, 31 Mar 2015 14:24:38 +0900
Message-ID: <551A2F96.2050000@jinso.co.jp>
References: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp> <1414034053-14750-2-git-send-email-cm-hiep@jinso.co.jp> <20150330043049.GE1568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
	kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150330043049.GE1568@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark-san

On 2015=E5=B9=B403=E6=9C=8830=E6=97=A5 13:30, Mark Brown wrote:
> On Thu, Oct 23, 2014 at 12:14:13PM +0900, Cao Minh Hiep wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> In order to transmit and receive data when have 32 bytes of data tha=
t
>> ready has prepared on Transmit/Receive Buffer to transmit or receive=
=2E
>> Instead transmits/receives a byte data using Transmit/Receive Buffer
>> Data Triggering Number will improve the speed of transfer data.
> Applied, thanks.  It'd have helped to be more explicit about what a
> "trigger number" is here - it's not a commonly used term.  "Trigger
> level" is more normal.
Thank you very much!
Hiep.
