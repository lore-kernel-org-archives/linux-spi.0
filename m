From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Tue, 8 Nov 2016 09:06:10 -0800
Message-ID: <CAAtXAHe_pz=oUpeP+t-Fy0z88LMmTeSffkD2Cbun3r+uTnmGYw@mail.gmail.com>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
 <2255968d-b97c-2b9c-4e4d-7f3717a748e3@denx.de> <01d1a97b-2f43-49a6-51fb-e223ef4dce9b@airwebreathe.org.uk>
 <4bdba358-db18-48f1-3286-a7a7f4c30215@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joel Holdsworth <joel@airwebreathe.org.uk>,
        Alan Tull <atull@opensource.altera.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Clifford Wolf <clifford@clifford.at>
To: Marek Vasut <marex@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4bdba358-db18-48f1-3286-a7a7f4c30215@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Marek,

On Mon, Nov 7, 2016 at 10:53 AM, Marek Vasut <marex@denx.de> wrote:

>> On the whole, I don't think the zero-length transfers are too
>> egregiously bad, and all the alternatives seem worse to me.
>
> So why not turn the CS line into GPIO and just toggle the GPIO?

Does that work with *all* SPI controllers?

Cheers,

Moritz
