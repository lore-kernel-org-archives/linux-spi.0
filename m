From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
Date: Mon, 9 Mar 2020 20:31:22 +0200
Message-ID: <CA+h21hodaPyY54fwRFNhmksg+9ugVvW7hndMCCc=cBG39D7jdQ@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-3-olteanv@gmail.com>
 <d8e39e402328b962cdbc25316a27eac8@walle.cc> <CA+h21hp4vC1c00rCgZo_hwQz3cE4dLBHjcgTHvf-+fS9a9VfxQ@mail.gmail.com>
 <a709dc91aac9124ed37ac1e7fcb7e105@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        peng.ma-3arQi8VN3Tc@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a709dc91aac9124ed37ac1e7fcb7e105-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 9 Mar 2020 at 20:19, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>

> Eg. is it big-endian or little-endian if there is no property at all?
>

I think it is "native endianness" in that case, i.e. big endian on big
endian CPU and little endian on little endian CPU.

Thanks,
-Vladimir
