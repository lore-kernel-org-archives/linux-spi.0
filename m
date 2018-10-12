From: Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH] dt-bindings: Add bindings for aliases node
Date: Fri, 12 Oct 2018 18:31:11 +0200
Message-ID: <1626442.UsWqDEgn3j@debian64>
References: <20180925210255.172734-1-mka@chromium.org> <20181009183141.GA126050@ban.mtv.corp.google.com> <20181012000837.GP22824@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Brian Norris <briannorris@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, swboyd@chromium.org,
        Florian Fainelli <f.fainelli@gmail.com>
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181012000837.GP22824@google.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, October 12, 2018 2:08:37 AM CEST Matthias Kaehlcke wrote:
> Maybe the doc should include a recommendation to use aliases
> sparingly? I'm open to input on that from folks who have a better
> understanding of the potential pitfalls 

I had a similar discussion with the OpenWrt devs over the
use of "led-$function" aliases in a DTS. I did a bit of digging and
found this wonderful emails from Mark Rutland regarding the general
use and abuse of aliases in a reply to a patch by Christer Weinigel 
"devicetree - document using aliases to set spi bus number."

<https://patchwork.kernel.org/patch/9133903/#19207021>

|"If those ports are physically organised and labelled the same, then
|using aliases could make sense, to describe the well-defined physical
|labels. If you've assigned the numbers artificially, or if the physical
|organisation differs across boards, then aliases are not the right tool
|for the job.
|
|In the latter cases we're altering the hardware description to suit an
|application, rather than providing the necessary abstraction, which is
|the kind of (ab)use of aliases which we want to avoid."

And he followed it up with a summary:
<https://patchwork.kernel.org/comment/19207071/>

|Typically, serial ports are much more user-accessible (physically), and
|much more directly useful to a user in a generic fashion. They're often
|labelled (physically or in a manual) with a number, and we use aliases
|to describe those labels to the kernel. The fact that the kernel may use
|that to drive its own internal numbering is immaterial to the binding.

So the gist of this is that aliases are meant for user-accessible /
physically devices/ports/etc... that are labeled as such. And this of
course works perfectly for power/status LEDs and such because they
usually have little "power" symbols/pictograms/lables near them. 
