From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH] spi: rspi: fix the bug related to mount/remount jffs2
Date: Mon, 13 Feb 2017 15:50:12 +0900
Message-ID: <58A15724.1060901@jinso.co.jp>
References: <1486342933-5307-1-git-send-email-cv-dong@jinso.co.jp> <CAMuHMdUyA9+KLaD9rY9gYjxjZcQ1bWKoDhP25mEAdZTr7E0uwA@mail.gmail.com> <ed0b8422-8ab1-7d8d-318f-343e6e2de17d@jinso.co.jp> <CAMuHMdVDgjBF+c-z4=LH+PD00oiNFqhShQuZ0ELS0S4YpQ=npg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?B?RHVuZ++8muS6ug==?= =?UTF-8?B?44K9?=
        <nv-dung@jinso.co.jp>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        DongCV <cv-dong@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVDgjBF+c-z4=LH+PD00oiNFqhShQuZ0ELS0S4YpQ=npg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Sorry to bother you!
> qspi_transfer_in() does:
>
>          while (n > 0) {
>                  len = qspi_set_receive_trigger(rspi, n);
>                  // len will be <= n
I agree. This is len = min value of n and 32.
>                  if (len == QSPI_BUFFER_SIZE) {
>                          // receive blocks of len bytes
Yes, This is len == 32 bytes
>                          ...
>                  } else {
>                          // receive n (not len) bytes
This is always n == len ( This case, len or n is always < 32)
Because this is the last n bytes should be received.

>                          ret = rspi_pio_transfer(rspi, NULL, rx, n);
>                          //
>                          if (ret < 0)
>                                  return ret;
>                          // bogus write (which your patch removes: OK)
>                          *rx++ = ret;
I agree. This code needs to be removed.

>                          // here we should also return (see below why)
>                          // (in qspi_transfer_out() we should "break")
>                  }
>                  // Either we received a block of len bytes
>                  // or we received n bytes, and the below is wrong if len < n!
>                  n -= len;
>                  // If len was < n, n will be non-zero, and we will receive more
>                  // bytes in the next iteration
I am sorry, I don't understand your opinion here also.
The following is my opinion:

In case of receiving n bytes data > 32 bytes (Ex: n= 50bytes)
The first loop, n= 50,and  len = 32 bytes by getting min value of 50 and 
32 from qspi_set_receive_trigger()
(this case was n < len).
Then it receives 32 bytes in "if (len == QSPI_BUFFER_SIZE)" statement.
After received 32bytes of data, n -= len is implemented. It means n =(n 
- len) = (50-32)= 18 bytes.
The first loop finished.

The second loop, n=18 bytes, and len = 18 bytes by getting min value of 
32 and 18 from qspi_set_receive_trigger().
This time, 'else' statement would be implemented. *rx pointer was 
increased into rspi_pio_transfer()
After received the last 18 bytes of data into 'else' statement, n -=len 
was implemented again.
It means n = (n - len) = (18 -18) = 0 byte.
The second loop finished.

This time n = 0, Completed receiving data.

In case of receiving n bytes data < 32 bytes  (Ex: n= 20 bytes).
It's the same with the second loop above.

Thank you.
Hiep.
