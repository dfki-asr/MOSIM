# MOSIM 

The MOSIM Framework is an open modular framework for efficient and interactive simulations and analysis of realistic human motions for professional applications. It enables the synthesis of motions independently from the actual target engine utilized to visualize the motions. The framework is defined using Apache Thrift and communicates via a TCP/IP protocol using thrift as a backend. 

## Framework Structure
The framework is distributed over several git repositories on github.
* [**MOSIM**](https://github.com/dfki-asr/MOSIM): the central repository containing the interface description, scripts for deployment, and docker files
* [MOSIM-Unity](https://github.com/dfki-asr/MOSIM-Unity): a unity specific repository containing different tools, demos and components utilizing the Unity 3D game engine
* [MOSIM-CSharp](https://github.com/dfki-asr/MOSIM-CSharp): a csharp specific repository containing different tools, demos and components implemented in C#
* [MOSIM-Python](https://github.com/dfki-asr/MOSIM-Python): a python specific repository containing different tools, demos and components implemented in Python

To be able to utilize the same code-base in Unity projects and standard Visual Studio projects, the implementation of classes for C# was gathered in the [**MMICSharp-Core**](https://github.com/dfki-asr/MMICSharp-Core) repository. This repository is automatically included as a [git-submodule](https://git-scm.com/book/de/v2/Git-Tools-Submodule) to the respective projects and should not be cloned on its own, as it does only contain source code and not project files. 

In addition, there are several repositories packaging different aspects of the framework. These repositories are configured to be installable by their respective package manager. 
* [MMIUnity-Core](https://github.com/dfki-asr/MMIUnity-Core): containing a wrapper of MMICSharp-Core for Unity which can be installed with the Unity package manager and Unity specific behaviors. 
* [MMIUnity-TargetEngine](https://github.com/dfki-asr/MMIUnity-TargetEngine): containing additional tools and features for Unity target engine projects
* [MMIPython-Core](https://github.com/dfki-asr/MMIPython-Core): containing a MOSIM integration to python and can be installed using pip

To ease the generation of MMUs from Unity, a [MMU-Generator](https://github.com/dfki-asr/MMU-Generator) was implemented and can be integrated in an existing Unity project (not the target engine project) with the Unity package manager. 

## Usage

This repository serves as a meta-repository to manage all other sub-repositories. To clone all repositories, please install [meta git](https://github.com/mateodelnorte/meta) on your system. Meta can be best installed using [node.js](https://nodejs.org/en/) using the command 
```Console
npm i -g meta
```


Afterwards you can utilize

```Console
meta git clone git@github.com:dfki-asr/MOSIM.git
```

to clone this repository and all sub-repositories. 

## Contributing

If you would like to contribute code you can do so through GitHub by forking the repository and sending a pull request.

If you want to get involved more actively in the MOSIM project, please contact Janis Sprenger (DFKI) for further information.

## License

This project is licensed under the [MIT License](./LICENSE). 

Notice: Before you use the program in productive use, please take all necessary precautions, e.g. testing and verifying the program with regard to your specific use. The program was tested solely for our own use cases, which might differ from yours.
